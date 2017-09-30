# this broke and is discussed here
# https://github.com/GoogleCloudPlatform/cloud-sdk-docker/issues/74

# FROM google/cloud-sdk:latest
#
# RUN apt-get install google-cloud-sdk
# RUN gcloud components install beta
#
#
#
#
#
#

FROM debian:jessie
ENV CLOUD_SDK_VERSION 171.0.0

#ENV INSTALL_COMPONENTS beta

RUN apt-get update -qqy && apt-get install -qqy \
        curl \
        gcc \
        python-dev \
        python-setuptools \
        apt-transport-https \
        lsb-release \
        openssh-client \
        git \
    && easy_install -U pip && \
    pip install -U crcmod && \
    export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && apt-get install -y google-cloud-sdk=${CLOUD_SDK_VERSION}-0

RUN gcloud components install beta

# turn some shit off
RUN gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image
