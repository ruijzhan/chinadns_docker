#!/bin/bash
SHA=$(curl -s 'https://api.github.com/repos/ruijzhan/ChinaDNS/commits' | grep sha | head -1)
docker build --build-arg SHA="$SHA" -t ruijzhan/chinadns .
