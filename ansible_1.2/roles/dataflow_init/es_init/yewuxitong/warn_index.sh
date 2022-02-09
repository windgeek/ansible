#!/usr/bin/env bash
es_master=$1
curl -XPUT "http://${es_master}/event_warning_relation" -H 'Content-Type: application/json' -d '
{
  "mappings": {
    "clue_event": {
      "properties": {
        "event_id": {
          "type": "keyword"
        },
        "create_time": {
          "type": "long"
        },
        "clue_id": {
          "type": "keyword"
        },
        "clue_source": {
          "type": "keyword"
        },
        "id": {
          "type": "keyword"
        }
      }
    }
  }
}
'