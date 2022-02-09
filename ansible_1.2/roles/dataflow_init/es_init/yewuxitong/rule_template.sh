#!/usr/bin/env bash
es_master=$1
curl -XPUT "http://${es_master}:9200/_template/recoginze_job_template" -H 'Content-Type: application/json' -d '
{
  "template": "rs_*",
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
      "number_of_replicas": "1",
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
          },
          "html_analyzer": {
            "filter": [
              "lowercase",
              "russian_stop",
              "russian_keywords",
              "russian_stemmer",
              "english_possessive_stemmer",
              "lowercase",
              "english_stop",
              "english_keywords",
              "english_stemmer"
            ],
            "char_filter": [
              "html_char_filter"
            ],
            "tokenizer": "standard"
          }
        },
        "filter": {
          "english_keywords": {
            "keywords": [
              ""
            ],
            "type": "keyword_marker"
          },
          "russian_stemmer": {
            "type": "stemmer",
            "language": "russian"
          },
          "english_stemmer": {
            "type": "stemmer",
            "language": "english"
          },
          "russian_stop": {
            "type": "stop",
            "stopwords": "_russian_"
          },
          "english_stop": {
            "type": "stop",
            "stopwords": "_english_"
          },
          "russian_keywords": {
            "keywords": [
              ""
            ],
            "type": "keyword_marker"
          },
          "english_possessive_stemmer": {
            "type": "stemmer",
            "language": "possessive_english"
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
          },
          "html_char_filter": {
            "type": "html_strip"
          }
        }
      }
    }
  },
  "mappings": {
    "_doc": {
      "properties": {
        "push": {
          "type": "boolean"
        },
        "excuteId": {
          "type": "keyword",
          "index": true,
          "doc_values": false
        },
        "iisTime": {
          "type": "long"
        },
        "isAuto": {
          "type": "long"
        },
        "file_key": {
          "type": "keyword",
          "doc_values": false
        },
        "eml_download_path": {
          "type": "keyword",
          "doc_values": false
        },
        "send_time": {
          "type": "long"
        },
        "subject": {
          "type": "text"
        },
        "insert_time": {
          "type": "long"
        },
        "message_id": {
          "type": "keyword",
          "doc_values": false
        },
        "from": {
          "analyzer": "sign_analyzer",
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword"
            }
          }
        },
        "to": {
          "analyzer": "sign_analyzer",
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword"
            }
          }
        },
        "cc": {
          "analyzer": "sign_analyzer",
          "type": "text",
          "fields": {
            "keyword": {
              "type": "keyword"
            }
          }
        },
        "region": {
          "type": "keyword"
        },
        "attachFlag": {
          "type": "long",
          "doc_values": false
        },
        "attachmentStr": {
          "analyzer": "sign_analyzer",
          "type": "text"
        },
        "attachmentList": {
          "type": "nested",
          "include_in_parent": true,
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
        "content": {
          "type": "text",
          "analyzer": "html_analyzer"
        },
        "file_type": {
          "type": "keyword"
        },
        "filter_type": {
          "type": "keyword"
        },
        "content_type": {
          "type": "keyword"
        }
      }
    }
  }
}
'