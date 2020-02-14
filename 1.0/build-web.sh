#!/bin/bash

cd $(dirname ${BASH_SOURCE[0]})
s2i build web centos/httpd-24-centos7 iipimage-web
