FROM concourse/git-resource

RUN wget -O /usr/local/bin/yq "https://github.com/mikefarah/yq/releases/download/2.4.1/yq_linux_amd64"
RUN chmod 777 /usr/local/bin/yq

RUN mv /opt/resource/in /opt/resource/git_in
COPY in.sh /opt/resource/in