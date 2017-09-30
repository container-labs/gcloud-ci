# this broke and is discussed here
# https://github.com/GoogleCloudPlatform/cloud-sdk-docker/issues/74

FROM google/cloud-sdk:latest

RUN apt-get install google-cloud-sdk
RUN gcloud components install beta
