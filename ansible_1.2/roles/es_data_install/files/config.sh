#!/usr/bin/env bash
# 延迟分配
curl -H "Content-Type: application/json" -XPUT 192.168.162.95:9200/_all/_settings -d '{
  "settings": {
    "index.unassigned.node_left.delayed_timeout": "1d" //挂掉节点上面的分片延迟1天分配。防止因集群单个节点临时挂掉后引发的recovery和rebalance操作。
  }
}'

# rebalance & recovery
curl -H "Content-Type: application/json" -XPUT 192.168.162.95:9200/_cluster/settings -d '{
	"persistent":{
        "indices.recovery.max_bytes_per_sec":"10240mb", //恢复时单个节点的总进出流量限制。默认40mb
        "indices.recovery.max_concurrent_file_chunks":5, //恢复时可并发拷贝的文件块数量。默认2
		"cluster.routing.allocation.cluster_concurrent_rebalance":"500", //整个集群范围内允许同时rebalance的shard数。 默认2
		"cluster.routing.allocation.node_initial_primaries_recoveries":"30", //单个节点主分片并行恢复的数据。默认4
		"cluster.routing.allocation.node_concurrent_recoveries":"500" //单个节点允许同时接受、传出恢复的shard数
	}
}'

