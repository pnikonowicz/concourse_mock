#!/bin/bash
# vim: set ft=sh

set -e

GIT_RESOURCE_DIR=${GIT_RESOURCE_DIR:-"/opt/resource/"}

payload=$TMPDIR/git-resource-request
cat > ${payload} <&0

#>&2 echo printing payload
#>&2 cat ${payload}
#>&2 echo done printing payload
#>&2 echo

output=$( cat ${payload} | ${GIT_RESOURCE_DIR}/git_in "$@")

git_destination=$1

# iterate through all the files and modify them so that they dont do anything
jq -c '.params.mock.files[]' ${payload} | while read file; do
    file_no_quotes=$(echo ${file} | sed -e 's/^"//' -e 's/"$//')
    file_path=${git_destination}/${file_no_quotes}
    >&2 echo "stubbing: $file_path"
    yq w ${file_path} 'run' INJECT_STUB_HERE > ${file_path}_stub
    cat ${file_path}_stub | sed 's/INJECT_STUB_HERE/\{"path": "bash", "args": \["-c","echo stubbed"\]\}/' > ${file_path}
done

#>&2 echo printing output
#>&2 echo "${output}"
#>&2 echo done printing output
#>&2 echo

echo "${output}"