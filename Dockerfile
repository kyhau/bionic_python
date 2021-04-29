FROM ubuntu:20.04
LABEL maintainer="virtualda@gmail.com"

RUN apt update && apt install -y \
    apt-transport-https \
    curl \
    software-properties-common \
    wget

# Install commonly used base packages
RUN apt update && apt install -y \
    build-essential=12.4\* \
    cmake=3.10.\* \
    g++=4:7.4.\* \
    gcc=4:7.4.\* \
    git=1:2.17.\* \
    libatlas3-base=3.10.\* \
    libffi-dev=3.2.\* \
    libgeos++-dev=3.6.\* \
    libgif-dev=5.1.\* \
    libhdf4-alt-dev=4.2.\* \
    liblapack3=3.7.\* \
    libnetcdf-dev=1:4.6.\* \
    libpq-dev \
    libproj-dev=4.9.\* \
    libssl-dev=1.1.\* \
    libxerces-c-dev=3.2.\* \
    make=4.\* \
    pandoc=1.19.\* \
    sendmail

################################################################################
# Install Python

RUN add-apt-repository -y ppa:deadsnakes/ppa

RUN apt update && apt install -y \
    python3.6-dev \
    python3.7-dev \
    python3.8-dev \
    python3.8-distutils \
    python3-dev=3.6.\*

# Install pip via PyPA's recommended way rather than the outdated apt repos
# See: https://pip.pypa.io/en/stable/installing/
RUN curl https://bootstrap.pypa.io/get-pip.py -o ./get-pip.py && \
    python3.8 get-pip.py && \
    python3.7 get-pip.py && \
    python3.6 get-pip.py

# Upgrade pip and install virtualenv
# Default pip is python3.6 version
RUN python3.8 -m pip install -U pip virtualenv virtualenvwrapper wheel && \
    python3.7 -m pip install -U pip virtualenv virtualenvwrapper wheel && \
    python3.6 -m pip install -U pip virtualenv virtualenvwrapper wheel

################################################################################
# Install docker

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

RUN add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

RUN apt update && apt install -y \
    docker-ce=5:18.09.\*


CMD ["/bin/bash"]
