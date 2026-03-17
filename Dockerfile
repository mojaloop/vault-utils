FROM ubuntu:20.04
ARG VAULT_VERSION=1.17.2
ARG UID=100
ARG GID=1000
ARG KUBECTL_VERSION=v1.26.7
ARG AWSCLI_VERSION=2.2.14

RUN groupadd -g "${GID}" vault && mkdir -p /home/vault \
  && usermod -l vault -g "${GID}" -d /home/vault _apt && chown -R vault:vault /home/vault


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
    && unzip /tmp/vault.zip -d /tmp && mv /tmp/vault /usr/local/bin/vault && chmod +x /usr/local/bin/vault \
    && wget https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip" -o /tmp/awscliv2.zip \
    && unzip /tmp/awscliv2.zip -d /tmp \
    && /tmp/aws/install \
    && rm -rf /tmp/awscliv2.zip /tmp/aws