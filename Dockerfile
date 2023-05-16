FROM ubuntu:20.04
ARG VAULT_VERSION=1.13.1

# Update apt and Install dependencies
RUN apt-get update && apt install software-properties-common -y && add-apt-repository ppa:rmescandon/yq -y \
    && apt update && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y \
    tzdata \
    curl \
    dnsutils \
    git \
    jq \
    yq \
    zip \
    wget \
    && rm -rf /var/lib/apt/lists/* \
    && wget -O /tmp/vault.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip \
    && unzip /tmp/vault.zip -d /tmp && mv /tmp/vault /usr/local/bin/vault && chmod +x /usr/local/bin/vault
