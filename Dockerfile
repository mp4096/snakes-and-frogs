FROM python:3.8-slim-buster
MAINTAINER Mikhail Pak <code@mp4096.com>

RUN apt-get update && \
  apt-get install -y --no-install-recommends wget && \
  rm -rf '/var/lib/apt/lists'

RUN mkdir '/tmp/build' && \
  cd '/tmp/build' && \
  wget -q 'https://golang.org/dl/go1.15.3.linux-amd64.tar.gz' && \
  tar -C '/tmp/build' -xzf 'go1.15.3.linux-amd64.tar.gz' && \
  wget -q 'https://github.com/jfrog/jfrog-cli/archive/v1.40.0.tar.gz' && \
  tar -xzf 'v1.40.0.tar.gz' && \
  cd './jfrog-cli-1.40.0' && \
  export PATH="${PATH}:/tmp/build/go/bin" && \
  sh './build/build.sh' && \
  go clean -cache && \
  mv 'jfrog' '/usr/local/bin/' && \
  cd && \
  rm -rf '/tmp/build' && \
  rm -rf '/root/go' && \
  rm -rf '/root/.cache/go'
