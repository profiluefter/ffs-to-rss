#!/bin/bash

# ffsclient tabs list --ignore-schema-errors --format json --client "asdfasdf" > tabs.json

yq --output-format=xml --from-file=json-to-rss.yq tabs.json
