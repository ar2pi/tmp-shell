FROM debian:bullseye-slim

ARG DEBIAN_FRONTEND=noninteractive
ARG YQ_VERSION=4.30.8
ARG JLESS_VERSION=0.8.0
ARG KUBECTL_VERSION=1.26.1

# install additional deb packages
RUN apt-get update -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false && apt-get install -y \
    libxcb1-dev libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev \
    gpg \
    unzip \
    lsof net-tools iproute2 iputils-ping dnsutils traceroute nmap tcpdump netcat socat \
    curl wget ftp openssh-client \
    nano vim \
    jq \
    && rm -rf /var/lib/apt/lists/*

# install yq
RUN curl -ksL https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/checksums -o /tmp/yq_checksums \
    && curl -ksL https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64 -o /tmp/yq_linux_amd64 \
    && checksum_matches=$(grep -c $(sha512sum /tmp/yq_linux_amd64 | cut -f1 -d" ") /tmp/yq_checksums) \
    && if [ $checksum_matches -eq 0 ]; then exit 1; fi \
    && cp /tmp/yq_linux_amd64 /usr/bin/yq \
    && chmod +x /usr/bin/yq \
    && rm -f /tmp/yq* \
    && yq --version

# install jless
RUN curl -ksL https://github.com/PaulJuliusMartinez/jless/releases/download/v${JLESS_VERSION}/jless-v${JLESS_VERSION}-x86_64-unknown-linux-gnu.zip -o /tmp/jless.zip \
    && unzip -q /tmp/jless.zip -d /tmp \
    && cp /tmp/jless /usr/bin/jless \
    && chmod +x /usr/bin/jless \
    && rm -f /tmp/jless* \
    && jless --version

# install kubectl
RUN curl -ksL https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /tmp/kubectl \
    && curl -ksL https://dl.k8s.io/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl.sha256 -o /tmp/kubectl_checksum \
    && checksum_matches=$(echo "$(cat /tmp/kubectl_checksum)  /tmp/kubectl" | sha256sum --check | grep "OK") \
    && if [ $checksum_matches -eq 0 ]; then exit 1; fi \
    && cp /tmp/kubectl /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && rm -f /tmp/kubectl* \
    && kubectl version --client

# install aws-cli
RUN curl -ksL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o /tmp/awscli-exe-linux-x86_64.zip \
    && unzip -q /tmp/awscli-exe-linux-x86_64.zip -d /tmp \
    && /tmp/aws/install \
    && rm -rf /tmp/aws* \
    && aws --version
