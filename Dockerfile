FROM ubuntu:18.04


 LABEL com.github.actions.name="nxxm CI"
 LABEL com.github.actions.description="Compile your code for linux"
 LABEL com.github.actions.icon="cloud"
 LABEL com.github.actions.color="red"

 LABEL repository="https://github.com/nxxm/nxxm_ci_docker"
 LABEL maintainer="Nxxm teams <damien@nxxm.io>"


# Install needed tools
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Paris
RUN apt-get -y update && apt-get install -y software-properties-common git build-essential locales ninja-build cmake libssl-dev python --assume-yes apt-utils
RUN locale-gen "en_US.UTF-8"
RUN add-apt-repository ppa:jonathonf/gcc-7.3
RUN apt-get update
RUN apt-get install -y gcc-7 g++-7
RUN apt-get update && apt-get install -y \
curl
RUN apt-get update && apt-get install -y \
unzip
RUN apt-get update && apt-get install -y \
sudo
RUN curl -o /usr/local/bin/jq http://stedolan.github.io/jq/download/linux64/jq && \
  chmod +x /usr/local/bin/jq
# Add script and run the script 
ADD ./src/entrypoint.sh /entrypoint.sh
COPY . .
CMD ["bash", "/entrypoint.sh"]
