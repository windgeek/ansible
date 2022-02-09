#!/bin/bash
s3cmd mb s3://ntc-oss-large-file-html
s3cmd mb s3://ntc-oss-large-file-eml
s3cmd mb s3://ntc-oss-large-file-bda
s3cmd mb s3://ntc-oss-large-file
s3cmd setlifecycle {{ dir }}/ntc-oss-large-file-html.xml s3://ntc-oss-large-file-html
s3cmd setlifecycle {{ dir }}/ntc-oss-large-file-eml.xml s3://ntc-oss-large-file-eml
s3cmd setlifecycle {{ dir }}/ntc-oss-large-file-bda.xml s3://ntc-oss-large-file-bda
s3cmd setlifecycle {{ dir }}/ntc-oss-large-file.xml s3://ntc-oss-large-file
s3cmd getlifecycle s3://ntc-oss-large-file-html
s3cmd getlifecycle s3://ntc-oss-large-file-eml
s3cmd getlifecycle s3://ntc-oss-large-file-bda
s3cmd getlifecycle s3://ntc-oss-large-file
