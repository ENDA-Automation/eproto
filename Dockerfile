FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    git && \
    wget https://go.dev/dl/go1.24.4.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.24.4.linux-amd64.tar.gz && \
    rm go1.24.4.linux-amd64.tar.gz && \
    apt-get clean && \
    export PATH=$PATH:/usr/local/go/bin && \
    go install github.com/bufbuild/buf/cmd/buf@v1.57.2 && \
    go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.36.10

ENV PATH="/usr/local/go/bin:${PATH}"
ENV PATH="/root/go/bin:${PATH}"

RUN wget https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh && bash install.sh
# set env
ENV NVM_DIR=/root/.nvm

ENV NODE_VERSION=22

RUN wget https://github.com/nanopb/nanopb/releases/download/nanopb-0.4.9.1/nanopb-0.4.9.1-linux-x86.tar.gz && \
    tar -xvzf nanopb-0.4.9.1-linux-x86.tar.gz -C /usr/local && \
    rm nanopb-0.4.9.1-linux-x86.tar.gz
# install node
RUN bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && npm i -g ts-proto"
RUN apt-get install -y nanopb
RUN apt-get install -y python3-protobuf

COPY messages.proto /workspace/messages.proto
COPY buf.gen.yaml /workspace/buf.gen.yaml
COPY buf.yaml /workspace/buf.yaml
COPY egate_messages.proto /workspace/egate_messages.proto
COPY gen.sh /workspace/gen.sh

WORKDIR /workspace

ENTRYPOINT [ "./gen.sh" ]
CMD []