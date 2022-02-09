#!/usr/bin/env bash

ps aux | grep grafana | grep -v grep | awk '{print $2}' | xargs kill -9