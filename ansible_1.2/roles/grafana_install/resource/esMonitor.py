#!/usr/bin/env python
__author__ = 'pan.lu'
import datetime
import time
import urllib
import json
import urllib2
import os
#import sys
import threading


elasticServerList = ["http://10.0.40.12:9200","http://10.0.40.6:9200","http://192.168.162.95:9200"]
elasticMonitoringCluster = 'http://10.0.40.12:9200'

# ElasticSearch Cluster to Monitor
#elasticServer = os.environ.get('ES_METRICS_CLUSTER_URL', 'http://10.0.40.12:9200')
interval = int(os.environ.get('ES_METRICS_INTERVAL', '10'))

# ElasticSearch Cluster to Send Metrics
elasticIndex = os.environ.get('ES_METRICS_INDEX_NAME', 'elasticsearch_metrics')
#elasticMonitoringCluster = os.environ.get('ES_METRICS_MONITORING_CLUSTER_URL', 'http://10.0.40.12:9200')

# Enable Elasticsearch Security
# read_username and read_password for read ES cluster information
# write_username and write_passowrd for write monitor metric to ES.
read_es_security_enable = False
read_username = "read_username"
read_password = "read_password"

write_es_security_enable = False
write_username = "write_username"
write_password = "write_password"

def handle_urlopen(urlData, read_username, read_password):
    if read_es_security_enable:
        try:
            password_mgr = urllib2.HTTPPasswordMgrWithDefaultRealm()
            password_mgr.add_password(None, urlData, read_username, read_password)
            handler = urllib2.HTTPBasicAuthHandler(password_mgr)
            opener = urllib2.build_opener(handler)
            urllib2.install_opener(opener)
            response = urllib2.urlopen(urlData)
            return response
        except Exception as e:
            print "Error:  {0}".format(str(e))
    else:
        try:
            response = urllib.urlopen(urlData)
            return response
        except Exception as e:
            print "Error:  {0}".format(str(e))

def fetch_clusterhealth(elasticServer):
    try:
        utc_datetime = datetime.datetime.utcnow()
        endpoint = "/_cluster/health"
        urlData = elasticServer + endpoint
        response = handle_urlopen(urlData,read_username,read_password)
        jsonData = json.loads(response.read())
        clusterName = jsonData['cluster_name']
        jsonData['@timestamp'] = str(utc_datetime.strftime('%Y-%m-%dT%H:%M:%S.%f')[:-3])
        if jsonData['status'] == 'green':
            jsonData['status_code'] = 0
        elif jsonData['status'] == 'yellow':
            jsonData['status_code'] = 1
        elif jsonData['status'] == 'red':
            jsonData['status_code'] = 2
        post_data(jsonData)
        return clusterName
    except IOError as err:
        print "IOError: Maybe can't connect to elasticsearch."
        clusterName = "unknown"
        return clusterName


def fetch_clusterstats(elasticServer):
    utc_datetime = datetime.datetime.utcnow()
    endpoint = "/_cluster/stats"
    urlData = elasticServer + endpoint
    response = handle_urlopen(urlData,read_username,read_password)
    jsonData = json.loads(response.read())
    jsonData['@timestamp'] = str(utc_datetime.strftime('%Y-%m-%dT%H:%M:%S.%f')[:-3])
    post_data(jsonData)


def fetch_nodestats(clusterName,elasticServer):
    utc_datetime = datetime.datetime.utcnow()
    endpoint = "/_cat/nodes?v&h=n"
    urlData = elasticServer + endpoint
    response = handle_urlopen(urlData,read_username,read_password)
    nodes = response.read()[1:-1].strip().split('\n')
    for node in nodes:
        endpoint = "/_nodes/%s/stats" % node.rstrip()
        urlData = elasticServer + endpoint
        response = handle_urlopen(urlData,read_username,read_password)
        jsonData = json.loads(response.read())
        nodeID = jsonData['nodes'].keys()
        try:
            jsonData['nodes'][nodeID[0]]['@timestamp'] = str(utc_datetime.strftime('%Y-%m-%dT%H:%M:%S.%f')[:-3])
            jsonData['nodes'][nodeID[0]]['cluster_name'] = clusterName
            newJsonData = jsonData['nodes'][nodeID[0]]
            post_data(newJsonData)
        except:
            continue


def fetch_indexstats(clusterName,elasticServer):
    utc_datetime = datetime.datetime.utcnow()
    endpoint = "/_stats"
    urlData = elasticServer + endpoint
    response = handle_urlopen(urlData,read_username,read_password)
    jsonData = json.loads(response.read())
    jsonData['_all']['@timestamp'] = str(utc_datetime.strftime('%Y-%m-%dT%H:%M:%S.%f')[:-3])
    jsonData['_all']['cluster_name'] = clusterName
    post_data(jsonData['_all'])


def post_data(data):
    utc_datetime = datetime.datetime.utcnow()
    url_parameters = {'cluster': elasticMonitoringCluster, 'index': elasticIndex,
        'index_period': utc_datetime.strftime("%Y.%m.%d"), }
    url = "%(cluster)s/%(index)s-%(index_period)s/message" % url_parameters
    headers = {'content-type': 'application/json'}
    try:
        req = urllib2.Request(url, headers=headers, data=json.dumps(data))
        if write_es_security_enable:
            password_mgr = urllib2.HTTPPasswordMgrWithDefaultRealm()
            password_mgr.add_password(None, url, write_username, write_password)
            handler = urllib2.HTTPBasicAuthHandler(password_mgr)
            opener = urllib2.build_opener(handler)
            urllib2.install_opener(opener)
            response = urllib2.urlopen(req)
        else:
            response = urllib2.urlopen(req)
    except Exception as e:
        print ("Error:  {0}".format(str(e)))

def fetch(elasticServer):
    clusterName = fetch_clusterhealth(elasticServer)
    if clusterName != "unknown":
        fetch_clusterstats(elasticServer)
        fetch_nodestats(clusterName, elasticServer)
        fetch_indexstats(clusterName, elasticServer)

def run(elasticServer):
    print(elasticServer+" start successed!")
    nextRun = 0
    while True:
        if time.time() >= nextRun:
            nextRun = time.time() + interval
            now = time.time()
            try:
                fetch(elasticServer)
            except Exception as e:
                print(e)
            elapsed = time.time() - now
            print "Total Elapsed Time: %s" % elapsed
            timeDiff = nextRun - time.time()
            if timeDiff >= 0:
                time.sleep(timeDiff)

def main():
    for elasticServer in elasticServerList:
        threading.Thread(target=run, args=(elasticServer,)).start()


if __name__ == '__main__':
    main()