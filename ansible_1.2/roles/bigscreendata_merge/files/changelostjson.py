import os
import sys
import json
import io
import re

BASE_DIR = os.getcwd()
f=io.open('/data1/mergecenter/mergelost.json',encoding='utf-8') 
res=f.read() 
# unicode #{u'Region': u'1', u'Total': u'6', u'Address': u'0'}
json_file=json.loads(res)
Total= 0 
Region= 0
List= []
lost_result= {}

# get Region 
def getRegion(Region):
   for jsons in json_file: 
     if isinstance(jsons,dict):
        for key in jsons.keys():
            if "Region" in key:
                Region=str(jsons.get(key))
   return Region

# get Total Count
def getTotal(Total):
   for jsons in json_file:
     if isinstance(jsons,dict):
        for key in jsons.keys():
            if "Total" in key:
                key_value=int(jsons.get(key))
                Total = Total + key_value
   return Total

# get Address list
def getAddress(List):
   for jsons in json_file:
     if isinstance(jsons,dict):
        for key in jsons.keys():
            if "Address" in key:
                Address=str(jsons.get(key))
                List.append(isIP(Address))
   return List 

def isIP(str):
    p = re.compile('^((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$')
    if p.match(str):
        return str 
    else:
        return str

def getResult(region,lists,total):
   listlen=len(lists)
   listslast= []
   # no lost server
   if listlen == 1 :
      lost_result["Region"] = lastregion
      lost_result["Address"] = "0"
      lost_result["Total"] = str(lastcount)
      lostjson = json.dumps(lost_result)
      print(lostjson)
      fileout=open('/data1/mergecenter/lost_result.json', 'w')
      fileout.write(lostjson)
      #os.popen('./changelostformat0.sh')
      #fileout.close
   else :
      lists.remove('0')
      for listip in lists:
          lost_result["Region"] = lastregion
          lost_result["Address"] = listip
          lost_result["Total"] = str(lastcount)
          lostjson = json.dumps(lost_result)
          fileout=open('/data1/mergecenter/lost_result.json', 'a+')
          fileout.write(lostjson)
      #    fileout.close
      #    os.system("./changelostformat1.sh")

lastregion=getRegion(Region)
lastcount=getTotal(Total)
# add address to list  ['192.168.94.41', '0', '0'] 
listarr=getAddress(List)
# distinct ipaddress ['0', '192.168.94.41'] 
listdis=list(set(listarr))
#print(listdis)
getResult(lastregion,listdis,lastcount)
