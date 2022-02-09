#!/usr/bin/env bash
sed -i '' 's/othercluster/{{hdfsHAClusterName}}/g' templates/*.sh
sed -i '' 's/message2kafka-1.5-jar-with-dependencies.jar/{{jar_version}}/g' templates/*.sh
