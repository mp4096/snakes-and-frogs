FROM golang:1.15.4-buster AS golang-build-env
WORKDIR /jfrog-cli-build
RUN apt-get update && \
  apt-get install -y --no-install-recommends wget && \
  rm -rf '/var/lib/apt/lists'
RUN wget -q 'https://github.com/jfrog/jfrog-cli/archive/v1.40.1.tar.gz' && \
  tar -xzf 'v1.40.1.tar.gz' && \
  cd './jfrog-cli-1.40.1' && \
  sh './build/build.sh'

FROM python:3.8-slim-buster
LABEL maintainer="Mikhail Pak <code@mp4096.com>"
COPY --from=golang-build-env '/jfrog-cli-build/jfrog-cli-1.40.1/jfrog' '/usr/local/bin/'
