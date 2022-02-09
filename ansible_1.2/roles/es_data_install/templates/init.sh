#!/usr/bin/env bash

hostIp=$1

# 延迟分配: 挂掉节点上面的分片延迟1天分配。防止因集群单个节点临时挂掉后引发的recovery和rebalance操作
curl -XPUT "http://${hostIp}/_all/_settings" -H 'Content-Type: application/json' -d '
{
  "settings": {
    "index.unassigned.node_left.delayed_timeout": "1d"
  }
}
'

# rebalance & recovery 配置
curl -XPUT "http://${hostIp}/_cluster/settings" -H 'Content-Type: application/json' -d '
{
	"persistent":{
        "indices.recovery.max_bytes_per_sec":"1024mb",
        "indices.recovery.max_concurrent_file_chunks":5,
		"cluster.routing.allocation.cluster_concurrent_rebalance":"500",
		"cluster.routing.allocation.node_initial_primaries_recoveries":"30",
		"cluster.routing.allocation.node_concurrent_recoveries":"500"
	}
}
'

# 修改监控模版
curl -XPUT "http://${hostIp}/_template/elasticsearch_metrics" -H 'Content-Type: application/json' -d '
{
  "template": "elasticsearch_metrics*",
  "settings": {
    "index.mapping.total_fields.limit": 5000
  },
  "mappings":{
      "message":{
          "properties":{
              "cluster_name": {
                "type": "text",
                "analyzer": "whitespace",
                "fields": {
                  "keyword": {
                    "type": "keyword",
                    "ignore_above": 256
                  }
                }
              }
          }
      }
  }
}
'

#修改慢查询日志
curl -XPUT "http://${hostIp}/k19*/_settings" -H 'Content-Type: application/json' -d '
{
    "index.search.slowlog.threshold.query.warn": "10s",
    "index.search.slowlog.threshold.query.info": "5s",
    "index.search.slowlog.threshold.query.debug": "2s",
    "index.search.slowlog.threshold.query.trace": "500ms",
    "index.search.slowlog.threshold.fetch.warn": "1s",
    "index.search.slowlog.threshold.fetch.info": "800ms",
    "index.search.slowlog.threshold.fetch.debug": "500ms",
    "index.search.slowlog.threshold.fetch.trace": "200ms",
    "index.search.slowlog.level": "info"
}
'

#修改聚合bucket个数上限
curl -XPUT "http://${hostIp}/_cluster/settings" -H 'Content-Type: application/json' -d '
{  "persistent": {    "search.max_buckets": 50000000  }}'