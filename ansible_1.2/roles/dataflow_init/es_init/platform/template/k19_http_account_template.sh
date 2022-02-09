#!/usr/bin/env bash
base_rest_url=${1}
#echo 'ip port:'${base_rest_url}
curl -XPUT "http://${base_rest_url}/_template/k19_http_account_template" -H 'Content-Type: application/json' -d '

{
  "order": 0,
  "template": "k19_http_account_*",
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
            "pattern": "\\.",
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
        "user_id": {
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword"
            }
          }
        },
        "session_id": {
          "type": "keyword",
          "doc_values": false
        },
        "user_name": {
          "type": "text",
          "analyzer": "sign_analyzer",
          "fields": {
            "keyword": {
              "type": "keyword",
              "ignore_above": 256
            }
          }
        },
        "password": {
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
        "status": {
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
