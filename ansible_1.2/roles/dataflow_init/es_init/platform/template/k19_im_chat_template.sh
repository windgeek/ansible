#!/usr/bin/env bash
base_rest_url=${1}
#echo 'ip port:'${base_rest_url}
curl -XPUT "http://${base_rest_url}/_template/k19_im_chat_template" -H 'Content-Type: application/json' -d '

{
  "order": 0,
  "template": "k19_im_chat_*",
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
            "tokenizer": "standard"
          }
        }
      },
      "number_of_replicas": "1"
    }
  },
  "mappings": {
      "properties": {
        "file_key": {
          "type": "text"
        },
        "app_label": {
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword"
            }
          }
        },
        "insert_time": {
          "type": "long"
        },
        "region": {
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword"
            }
          }
        },
        "from_user_name": {
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword"
            }
          }
        },
        "from_user_id": {
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword"
            }
          }
        },
        "to_user_name": {
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword"
            }
          }
        },
        "to_user_id": {
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword"
            }
          }
        },
        "content": {
          "type": "text"
        },
        "message_id": {
          "type": "text"
        },
        "event_time": {
          "type": "long",
          "doc_values": false
        },
        "DURATION": {
          "type": "long",
          "doc_values": false
        },
        "RULEKEY": {
          "type": "keyword",
          "doc_values": false
        },
        "chat_type": {
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword"
            }
          }
        },
        "protocol": {
           "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword"
            }
          }
        }
      }
  },
  "aliases": {}
}
'
