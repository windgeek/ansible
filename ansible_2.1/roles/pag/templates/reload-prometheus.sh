#!/usr/bin/env bash

ps aux | grep prometheus | grep -v gerp | awk '{print $2}' | xargs kill -HUP