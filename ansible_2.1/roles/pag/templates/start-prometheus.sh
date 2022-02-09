#!/usr/bin/env bash

nohup {{pag.dir}}/prometheus/prometheus --config.file={{pag.dir}}/prometheus/prometheus.yml --web.enable-admin-api --web.enable-lifecycle &