# encoding: utf-8

import os
import sys

BASE_DIR = os.getcwd()
CPU_RESULT = "{}/cpumem_result.json".format(BASE_DIR)
OTHER_RESULT = "{}/other_result.json".format(BASE_DIR)
#cpu_num = 0
#other_num = 0

with open(CPU_RESULT, "a+") as cf:
    cf.write("[")
with open(OTHER_RESULT, "a+") as ef:
    ef.write("[")

for root, dirs, files in os.walk(BASE_DIR):
    for name in files:
        if "getcpu" in name:
#            print name
#            cpu_num += 1
            with open(CPU_RESULT, 'a+') as cf:
                with open(os.path.join(root, name), 'r') as ef:
                    cf.write(ef.read()) 
                    cf.write(",")
        elif "getother" in name:
#            other_num += 1
            with open(OTHER_RESULT, 'a+') as mf:
                with open(os.path.join(root, name), 'r') as ef:
                    mf.write(ef.read())
                    mf.write(",")

with open(CPU_RESULT, "a+") as ef:
    ef.write("]")#print cpu_num, other_num

with open(OTHER_RESULT, "a+") as ef:
    ef.write("]")#print cpu_num, other_num

#with open(OTHER_RESULT, "r") as rf:
#    lines=rf.readlines()
#with open(OTHER_RESULT, "w+") as cf:
#    #print cf.readlines()[-1]
#    #cf.readlines()[-1] = "]"
#     for rm in lines:
#        if ',]' in rm:
#          #cf.write("]")
#          cf.remove(rm)
	
#    cf.write("]")
#with open(OTHER_RESULT, "a+") as ef:
#    ef.write("]")
