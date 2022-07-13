FROM ubuntu:18.04

ARG TERRAFORM_VER
ARG EKS_KUBECTL_VER

ENV TERRAFORM_VER=${TERRAFORM_VER:-0.14.3}
ENV EKS_KUBECTL_VER=${EKS_KUBECTL_VER:-1.19.6/2021-01-05}
ENV DEBIAN_FRONTEND="noninteractive"

# Install utils
RUN set -ex \
    && echo 'Acquire::CompressionTypes::Order:: "gz";' > /etc/apt/apt.conf.d/99use-gzip-compression \
    && apt-get update \
    && apt install -y apache2-utils zip unzip jq curl wget git gettext-base

# Kubectl
RUN curl -s https://amazon-eks.s3.cn-north-1.amazonaws.com.cn/${EKS_KUBECTL_VER}/bin/linux/amd64/kubectl -o "/usr/local/bin/kubectl" \
    && chmod +x /usr/local/bin/kubectl

# AWS CLI
RUN curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip -q awscliv2.zip && rm awscliv2.zip \
    && ./aws/install  -i /usr/local/aws-cli -b /usr/local/bin

# Terraform
RUN curl -s https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_amd64.zip -o "terraform.zip" \
    && unzip -q terraform.zip && rm terraform.zip \
    && mv terraform /usr/local/bin/ \
    && chmod +x /usr/local/bin/terraform

#OPA and yq
RUN wget https://github.com/mikefarah/yq/releases/download/3.4.0/yq_linux_amd64 -O /usr/bin/yq \
    && chmod +x /usr/bin/yq \
    && curl -L -o opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64 -o "opa" \
    && chmod 755 ./opa \
    && mv ./opa /usr/local/bin/ 

#Terraform providers
RUN mkdir /usr/local/bin/tf-plugins
COPY providers.tf /usr/local/bin/tf-plugins
WORKDIR /usr/local/bin/tf-plugins
RUN terraform init 