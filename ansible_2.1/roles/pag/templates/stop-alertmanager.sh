#!/usr/bin/env bash

ps aux | grep alertmanager | grep -v grep | awk '{print $2}' | xargs kill -9