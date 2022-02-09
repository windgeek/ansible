# encoding: utf-8

import os
import sys

BASE_DIR = os.getcwd()
CPU_RESULT = "{}/cpumem_result.json".format(BASE_DIR)
OTHER_RESULT = "{}/other_result.json".format(BASE_DIR)
LOST_RESULT = "{}/lost_result.json".format(BASE_DIR)
MERGECPUMEM_RESULT = "{}/mergecpumem.json".format(BASE_DIR)
MERGEOTHER_RESULT = "{}/mergeother.json".format(BASE_DIR)
MERGELOST_RESULT = "{}/mergelost.json".format(BASE_DIR)

for root, dirs, files in os.walk(BASE_DIR):
    for name in files:
        if "cpumem_result" in name:
           with open(MERGECPUMEM_RESULT, 'a+') as cf:
              with open(os.path.join(root, name), 'r') as ef:
                    cf.write(ef.read()) 
        elif "other_result" in name:
          with open(MERGEOTHER_RESULT, 'a+') as mf:
              with open(os.path.join(root, name), 'r') as ef:
                  mf.write(ef.read())
        elif "lost_result" in name:
          with open(MERGELOST_RESULT, 'a+') as lf:
             with open(os.path.join(root, name), 'r') as wf:
                 lf.write(wf.read())
