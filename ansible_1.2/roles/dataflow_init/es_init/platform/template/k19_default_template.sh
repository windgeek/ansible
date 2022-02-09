#!/usr/bin/env bash
base_rest_url=${1}
#echo 'ip port:'${base_rest_url}
curl -XPUT "http://${base_rest_url}/_template/k19_default_template" -H 'Content-Type: application/json' -d '
{
  "order": 30,
  "index_patterns": [
    "k19_*"
  ],
  "settings": {
    "index": {
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
        "char_filter": {
          "ipv6_filter": {
            "pattern": ":",
            "type": "pattern_replace",
            "replacement": "."
          }
        },
        "analyzer": {
          "default": {
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
            "tokenizer": "standard"
          },
          "ip_analyzer": {
            "type": "custom",
            "char_filter": [
              "ipv6_filter"
            ],
            "tokenizer": "ip_tokenizer"
          }
        },
        "tokenizer": {
          "ip_tokenizer": {
            "type": "path_hierarchy",
            "delimiter": "."
          }
        }
      }
    }
  },
  "mappings": {
      "properties": {
        "s_city": {
          "type": "keyword"
        },
        "s_port": {
          "type": "text",
          "fields": {
            "keyword": {
              "ignore_above": 256,
              "type": "keyword"
            }
          }
        },
        "found_time": {
          "type": "long"
        },
        "s_geo": {
          "type": "keyword",
          "doc_values": false
        },
        "s_ip": {
          "analyzer": "ip_analyzer",
          "type": "text",
          "fields": {
            "keyword": {
              "ignore_above": 256,
              "type": "keyword"
            }
          }
        },
        "d_country": {
          "type": "keyword"
        },
        "d_city": {
          "type": "keyword"
        },
        "d_geo": {
          "type": "keyword",
          "doc_values": false
        },
        "d_ip": {
          "analyzer": "ip_analyzer",
          "type": "text",
          "fields": {
            "keyword": {
              "ignore_above": 256,
              "type": "keyword"
            }
          }
        },
        "radius_account": {
          "type": "text",
          "fields": {
            "keyword": {
              "ignore_above": 256,
              "type": "keyword"
            }
          }
        },
        "s_country": {
          "type": "keyword"
        },
        "d_port": {
          "type": "text",
          "fields": {
            "keyword": {
              "ignore_above": 256,
              "type": "keyword"
            }
          }
        }
      }
  },
  "aliases": {}
}
'
