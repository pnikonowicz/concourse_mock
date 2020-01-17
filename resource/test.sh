#!/usr/bin/env bash

echo "in test.sh"

cat ./test/payload | GIT_RESOURCE_DIR="test/" ./in.sh "target_dir"
