#!/bin/bash
# vim: set ft=sh

set -e

GIT_RESOURCE_DIR=${GIT_RESOURCE_DIR:-"/opt/resource/"}

payload=$TMPDIR/git-resource-request
cat > ${payload} <&0

>&2 echo printing payload
>&2 cat ${payload}
>&2 echo done printing payload
>&2 echo

output=$( cat ${payload} | ${GIT_RESOURCE_DIR}/git_in "$@")

>&2 echo printing output
>&2 echo "${output}"
>&2 echo done printing output
>&2 echo

echo "${output}"