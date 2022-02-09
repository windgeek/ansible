#!/usr/bin/env bash

nohup {{pag.dir}}/alertmanager/alertmanager --config.file=alertmanager.yml --data.retention=720h &