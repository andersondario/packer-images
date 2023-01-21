#!/usr/bin/bash

sed -i "s/####/$PROMETHEUS_BASIC_AUTH_PASS/g" config/web.yml