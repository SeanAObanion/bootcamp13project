#!/bin/bash

curl -s http://ipinfo.io/$1 | grep country | awk -F" " '{print $2}' | sed 's/"//g' | sed 's/,//g'
