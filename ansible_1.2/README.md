## 1.ClickHouse
#### 存放位置及目录结构：
`roles/clickhouse_install/template `

```bash
1.ClickHouse
存放位置及目录结构： 
roles/clickhouse_install/template 
. 
├── handlers 
│   └── main.yml 
├── meta 
│   └── main.yml 
├── README.md 
├── tasks 
│   └── main.yml 
├── templates 
│   ├── config.xml 
│   ├── metrika.xml.j2 
│   └── users.xml 
└── vars 
    └── main.yml 
```

#### 初始化脚本说明：

## 2.ElasticSearch
#### 存放位置及目录结构：
`roles/es_install/template `
```bash
. 
├── dataflow 
│   ├── k19_templates_init.sh 
│   └── template 
│       ├── k19_default_template.sh 
│       ├── k19_http_account_template.sh 
│       ├── k19_http_content_template.sh 
│       ├── k19_im_chat_template.sh 
│       ├── k19_im_profile_template.sh 
│       ├── k19_im_voip_template.sh 
│       ├── k19_mail_content_template.sh 
│       ├── k19_social_chat_template.sh 
│       ├── k19_social_posts_template.sh 
│       ├── k19_social_profile_template.sh 
│       └── k19_web_mail_template.sh 
└── yewuxitong 
    ├── rule_template.sh 
    └── warn_index.sh 
```
#### 初始化脚本说明：
## 1.脚本位置:
`roles/dataflow_init/es_init`
## 2.使用:
`sh k19_templates_init.sh IP:9200`


## 3.Neo4j
#### 重要：一定要创建索引，否则会严重影响数据查询结果
#### 建立
`create index on :node(obj_id)`
#### 查询
`:schema`

## 4.Kafka

#### 存放位置：

`roles/dataflow_init/Kafka/kafka_init_k19.sh`  现场环境使用

`roles/dataflow_init/Kafka/kafka_k19.sh`   国内环境使用

#### 执行方式：

`sh kafka_init_k19.sh {zk host}:2181 {replication-factor} {region}`

* zk host:zookeeper地址
* replication-factor：topic副本数，统一指定为2副本
* region:地区，参数取值范围在case循环中。
`e.g. sh kafka_init_k19.sh 172.18.9.51:2181 2 Astana`

## 5.HBase

#### 存储路径为：

`roles/dataflow_init/HBase/hbase_oss_init.sh  OSS服务的初始化脚本`

`roles/dataflow_init/HBase/hbase_system_init.sh 业务系统的初始化脚本`

`roles/dataflow_init/HBase/hbase_dataflow_init.sh 数据流的初始化脚本`

**在OSS初始化脚本中，对于表ntc_oss_small_file，在执行的时候需要根据机器数修改NUMREGIONS的值，NUMREGIONS的值为：regionserver机器数 * 600，例如：集群的regionserver机器数为3，那么NUMREGIONS的值设置为1800。**