FROM alpine:3.15

ARG KUBECTL_VERSION=v1.20.6
ARG TARGETPLATFORM=linux/amd64
ENV TERM xterm

WORKDIR /root


RUN echo -e 'http://dl-cdn.alpinelinux.org/alpine/v3.9/main\nhttp://dl-cdn.alpinelinux.org/alpine/v3.9/community' >> /etc/apk/repositories && \
   apk update && apk add \
   bash \
   bash-completion \
   busybox-extras \
   net-tools \
   mysql-client \
   vim \
   curl \
   wget \
   jq \
   git \
   gzip \
   mongodb-tools \
   mongodb \
   yaml-cpp=0.6.2-r2 \
   tcpdump \
   util-linux \
   tzdata \
   ca-certificates && \
   update-ca-certificates && \
   \cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&\echo "Asia/Shanghai" > /etc/timezone && \
   apk del tzdata && \
   rm -rf /var/cache/apk/* && \
   curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/${TARGETPLATFORM}/kubectl && \
   chmod +x ./kubectl && \
   mv ./kubectl /usr/local/bin/kubectl && \
   chmod +x /usr/local/bin/kubectl && \
   echo -e 'source /usr/share/bash-completion/bash_completion\nsource <(kubectl completion bash)' >> ~/.bashrc


CMD ["/bin/bash"]
