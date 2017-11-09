# this broke and is discussed here
# https://github.com/GoogleCloudPlatform/cloud-sdk-docker/issues/74
FROM debian:jessie
ENV CLOUD_SDK_VERSION 179.0.0

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
    pip install -U crcmod

RUN curl "https://storage.googleapis.com/cloud-sdk-release/google-cloud-sdk-$CLOUD_SDK_VERSION-linux-x86.tar.gz" > cloud-sdk.tar.gz && \
    tar -xvf cloud-sdk.tar.gz && \
    cd google-cloud-sdk && ./install.sh
# add gcloud binary to the path
ENV PATH="/google-cloud-sdk/bin:${PATH}"
RUN gcloud components install beta

# turn some shit off
RUN gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image

CMD ["gcloud", "components", "list"]
