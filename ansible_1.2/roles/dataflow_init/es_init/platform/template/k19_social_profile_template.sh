#!/usr/bin/env bash
base_rest_url=${1}
#echo 'ip port:'${base_rest_url}
curl -XPUT "http://${base_rest_url}/_template/k19_social_profile_template" -H 'Content-Type: application/json' -d '
{
        "order": 0,
        "template": "k19_social_profile_*",
        "settings": {
                "index": {
                        "search": {
                                "slowlog": {
                                        "threshold": {
                                                "fetch": {
                                                        "debug": "100ms"
                                                },
                                                "query": {
                                                        "debug": "5s"
                                                }
                                        }
                                }
                        },
                        "refresh_interval": "5s",
                        "indexing": {
                                "slowlog": {
                                        "threshold": {
                                                "index": {
                                                        "info": "50ms"
                                                }
                                        }
                                }
                        },
                        "number_of_shards": "5",
                        "translog": {
                                "flush_threshold_size": "2g"
                        },
                        "merge": {
                                "scheduler": {
                                        "max_thread_count": "1"
                                }
                        },
                        "analysis": {
                                "analyzer": {
                                        "sign_analyzer": {
                                                "char_filter": [
                                                        "dot_pattern_filter",
                                                        "underline_pattern_filter"
                                                ],
                                                "tokenizer": "standard"
                                        }
                                },
                                "char_filter": {
                                        "dot_pattern_filter": {
                                                "pattern": ".",
                                                "type": "pattern_replace",
                                                "replacement": " "
                                        },
                                        "underline_pattern_filter": {
                                                "pattern": "_",
                                                "type": "pattern_replace",
                                                "replacement": " "
                                        }
                                }
                        },
                        "number_of_replicas": "1"
                }
        },
        "mappings": {
                "http": {
                        "properties": {
                                "app_label": {
                                        "type": "keyword"
                                },
                                "category": {
                                        "type": "keyword",
                                        "doc_values": false
                                },
                                "action": {
                                        "type": "keyword",
                                        "doc_values": false
                                },
                                "device_type": {
                                        "type": "keyword"
                                },
                                "insert_time": {
                                        "type": "long"
                                },
                                "region": {
                                        "type": "keyword"
                                },
                                "uuid": {
                                        "type": "keyword",
                                        "doc_values": false
                                },
                                "others": {
                                        "type": "keyword",
                                        "doc_values": false
                                },
                                "user_name": {
                                        "type": "text"
                                },
                                "sn": {
                                        "type": "keyword",
                                        "doc_values": false
                                },
                                "user_id": {
                                        "type": "keyword",
                                        "doc_values": false
                                },
                                "user_type": {
                                        "type": "keyword"
                                },
                                "msisdn": {
                                        "type": "keyword",
                                        "doc_values": false
                                },
                                "mail": {
                                        "analyzer": "sign_analyzer",
                                        "type": "text",
                                        "fields": {
                                                "keyword": {
                                                        "type": "keyword"
                                                }
                                        }
                                },
                                "birthday": {
                                        "type": "keyword",
                                        "doc_values": false
                                },
                                "gender": {
                                        "type": "keyword",
                                        "doc_values": false
                                }
                        }
                }
        },
        "aliases": {}
}
'