#!/usr/bin/env bash

ps aux | grep prometheus | grep -v grep | awk '{print $2}' | xargs kill -9