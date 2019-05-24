FROM ubuntu:18.04
LABEL maintainer="virtualda@gmail.com"

# Add the add-apt-repository command
RUN apt update && apt install -y \
    apt-transport-https \
    curl=7.58.\* \
    software-properties-common

# Update the package lists
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository -y ppa:webupd8team/java && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

# Install commonly used base packages
RUN apt update && apt install -y \
    build-essential=12.4\* \
    cmake=3.10.\* \
    docker-ce=5:18.09.\* \
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
    python3.6-dev \
    python3.7-dev \
    python3.8-dev \
    python3-dev=3.6.\* \
    sendmail=8.15.\* \
    wget=1.19.\*

# Install pip via PyPA's recommended way rather than the outdated apt repos
# See: https://pip.pypa.io/en/stable/installing/
RUN curl https://bootstrap.pypa.io/get-pip.py -o ./get-pip.py && \
    python3.8 get-pip.py && \
    python3.7 get-pip.py && \
    python3.6 get-pip.py

# Upgrade pip and install virtualenv
# Default pip is python3.6 version
RUN python3.8 -m pip install -U pip virtualenvwrapper wheel && \
    python3.7 -m pip install -U pip virtualenvwrapper wheel && \
    python3.6 -m pip install -U pip virtualenvwrapper wheel

CMD ["/bin/bash"]
