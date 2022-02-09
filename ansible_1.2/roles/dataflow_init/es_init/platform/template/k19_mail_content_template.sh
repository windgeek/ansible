#!/usr/bin/env bash
base_rest_url=${1}
#echo 'ip port:'${base_rest_url}
curl -XPUT "http://${base_rest_url}/_template/k19_mail_content_template" -H 'Content-Type: application/json' -d '
{
  "order": 0,
  "index_patterns": [
    "k19_mail_content_*"
  ],
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
              "suffix_delete_filter",
              "dot_pattern_filter",
              "underline_pattern_filter"
            ],
            "tokenizer": "standard"
          }
        },
        "char_filter": {
          "suffix_delete_filter": {
            "pattern": "(?<=@[a-zA-Z-0-9]{0,1000})\\..*",
            "type": "pattern_replace",
            "replacement": " "
          },
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
        "eml_file": {
          "type": "text"
        },
        "mail_to": {
          "analyzer": "sign_analyzer",
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword"
            }
          }
        },
        "attachment_list": {
          "include_in_parent": true,
          "type": "nested",
          "properties": {
            "attachmentName": {
              "analyzer": "sign_analyzer",
              "type": "text"
            },
            "contentType": {
              "type": "keyword"
            }
          }
        },
        "subject": {
          "type": "text"
        },
        "attach_flag": {
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
        "message_id": {
          "type": "text"
        },
        "cfg_id": {
          "type": "text"
        },
        "mail_from": {
          "analyzer": "sign_analyzer",
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword"
            }
          }
        },
        "attachment_names": {
          "analyzer": "sign_analyzer",
          "type": "text"
        },
        "content": {
          "type": "text"
        },
        "mail_cc": {
          "analyzer": "sign_analyzer",
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
        "region": {
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword"
            }
          }
        },
        "mail_bcc": {
          "analyzer": "sign_analyzer",
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword"
            }
          }
        },
        "event_time": {
          "type": "long"
        }
      }
  },
  "aliases": {}
}
'
