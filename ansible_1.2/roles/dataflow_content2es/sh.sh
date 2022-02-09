#!/usr/bin/env bash
sed -i '' 's/tsecluster/{{hdfsHAClusterName}}/g' templates/*.sh
sed -i '' 's/content2es.jar/{{jar_version}}/g' templates/*.sh

