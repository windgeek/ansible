#!/usr/bin/env bash
base_rest_url=${1}
#echo 'ip port:'${base_rest_url}
curl -XPUT "http://${base_rest_url}/_template/k19_http_content_template" -H 'Content-Type: application/json' -d '
{
  "order": 0,
  "index_patterns": [
    "k19_http_content_*"
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
        "analyzer": {
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
        "char_filter": {
          "html_char_filter": {
            "type": "html_strip"
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
        "website": {
          "type": "text",
          "fields": {
            "keyword": {
              "ignore_above": 256,
              "type": "keyword"
            }
          }
        },
        "content_type": {
          "type": "text",
          "fields": {
            "keyword": {
              "ignore_above": 256,
              "type": "keyword"
            }
          }
        },
        "file_type": {
          "type": "text",
          "fields": {
            "keyword": {
              "ignore_above": 256,
              "type": "keyword"
            }
          }
        },
        "insert_time": {
          "type": "long"
        },
        "cfg_id": {
          "type": "text"
        },
        "region": {
          "type": "text",
          "fields": {
            "keyword": {
              "ignore_above": 256,
              "type": "keyword"
            }
          }
        },
        "content": {
          "analyzer": "html_analyzer",
          "type": "text"
        }
      }
  },
  "aliases": {}
}
'
