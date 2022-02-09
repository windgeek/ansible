<<<<<<< HEAD
# -*- coding: utf-8 -*-
# @Time   : 2020/3/3 9:58
# @Author : jindong.zhu

import openpyxl
import json

def readFromJson(file):
    with open(file, 'r', encoding='utf8') as fr:
        jsonData = json.load(fr)

        # get ck info
        for i in range(0, len(jsonData["panels"])):
            # print(jsonData["panels"][i]["title"])
            for j in range(0, len(jsonData["panels"][i]["panels"])):
                # print(jsonData["panels"][i]["panels"][j]["title"])
                if "targets" in jsonData["panels"][i]["panels"][j]:
                    if "expr" in jsonData["panels"][i]["panels"][j]["targets"][0]:
                        print(jsonData["panels"][i]["panels"][j]["targets"][0]["expr"])
        # get ES info
        # for i in range(0, len(jsonData["panels"])):
        #     # print(jsonData["panels"][i]["title"])
        #     for j in range(0, len(jsonData["panels"][i]["panels"])):
        #         # print(jsonData["panels"][i]["panels"][j]["title"])
        #         if "targets" in jsonData["panels"][i]["panels"][j]:
        #             if "metrics" in jsonData["panels"][i]["panels"][j]["targets"][0]:
        #                 if "field" in jsonData["panels"][i]["panels"][j]["targets"][0]["metrics"][0]:
        #                     print(jsonData["panels"][i]["panels"][j]["targets"][0]["metrics"][0]["field"])


        # get Kafka info
        # for i in range(0, len(jsonData["panels"])):
        #     for j in range(0, len(jsonData["panels"][i]["panels"])):
        #         print(jsonData["panels"][i]["panels"][j]["title"])
        #         print(jsonData["panels"][i]["panels"][j]["targets"][0]["expr"])


        # get ceph info
        # for i in range(0, len(jsonData["panels"])):
        #     print(jsonData["panels"][i]["title"])
        #     if "targets" in jsonData["panels"][i]:
        #         print(jsonData["panels"][i]["targets"][0]["expr"])


if __name__ == '__main__':
    # readFromJson('C:\\Users\\LT-0861\\PycharmProjects\\JsonDeal\\ClickHouse.json')
    readFromJson('C:\\Users\\sisi.wang\\Desktop\\\Ceph.json')
=======
# -*- coding: utf-8 -*-
# @Time   : 2020/3/3 9:58
# @Author : jindong.zhu

import openpyxl
import json

def readFromJson(file):
    with open(file, 'r', encoding='utf8') as fr:
        jsonData = json.load(fr)

        # get ck info
        for i in range(0, len(jsonData["panels"])):
            # print(jsonData["panels"][i]["title"])
            for j in range(0, len(jsonData["panels"][i]["panels"])):
                # print(jsonData["panels"][i]["panels"][j]["title"])
                if "targets" in jsonData["panels"][i]["panels"][j]:
                    if "expr" in jsonData["panels"][i]["panels"][j]["targets"][0]:
                        print(jsonData["panels"][i]["panels"][j]["targets"][0]["expr"])
        # get ES info
        # for i in range(0, len(jsonData["panels"])):
        #     # print(jsonData["panels"][i]["title"])
        #     for j in range(0, len(jsonData["panels"][i]["panels"])):
        #         # print(jsonData["panels"][i]["panels"][j]["title"])
        #         if "targets" in jsonData["panels"][i]["panels"][j]:
        #             if "metrics" in jsonData["panels"][i]["panels"][j]["targets"][0]:
        #                 if "field" in jsonData["panels"][i]["panels"][j]["targets"][0]["metrics"][0]:
        #                     print(jsonData["panels"][i]["panels"][j]["targets"][0]["metrics"][0]["field"])


        # get Kafka info
        # for i in range(0, len(jsonData["panels"])):
        #     for j in range(0, len(jsonData["panels"][i]["panels"])):
        #         print(jsonData["panels"][i]["panels"][j]["title"])
        #         print(jsonData["panels"][i]["panels"][j]["targets"][0]["expr"])


        # get ceph info
        # for i in range(0, len(jsonData["panels"])):
        #     print(jsonData["panels"][i]["title"])
        #     if "targets" in jsonData["panels"][i]:
        #         print(jsonData["panels"][i]["targets"][0]["expr"])


if __name__ == '__main__':
    # readFromJson('C:\\Users\\LT-0861\\PycharmProjects\\JsonDeal\\ClickHouse.json')
    readFromJson('C:\\Users\\sisi.wang\\Desktop\\\Ceph.json')
>>>>>>> d4ed09fc798aa49a1bbef2b29cb6c5df99e5e369
