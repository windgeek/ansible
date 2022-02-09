#!/usr/bin/env bash
base_rest_url=${1}
#echo 'ip port:'${base_rest_url}
curl -XPUT "http://${base_rest_url}/_template/k19_social_posts_template" -H 'Content-Type: application/json' -d '

{
  "order": 0,
  "template": "k19_social_posts_*",
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
        "file_key": {
          "type": "text"
        },
        "DURATION": {
          "type": "long",
          "doc_values": false
        },
        "RULEKEY": {
          "type": "keyword",
          "doc_values": false
        },
        "user_id": {
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword"
            }
          }
        },
        "user_name": {
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword"
            }
          }
        },
        "desc": {
          "type": "text"
        },
        "user_portrait": {
          "type": "keyword",
          "doc_values": false
        },
        "comment_id": {
          "type": "text"
        },
        "content": {
          "type": "text"
        },
        "event_time": {
          "type": "long",
          "doc_values": false
        },
        "post_id": {
          "type": "text"
        },
        "event_type": {
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
