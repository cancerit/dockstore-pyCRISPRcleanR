#!/bin/bash

set -eux

# for R installation

apt-get update
apt-get install -yq --no-install-recommends lsb-release
UBUNTU_VER=`lsb_release -cs`
echo "deb http://cran.rstudio.com/bin/linux/ubuntu $UBUNTU_VER/" >> /etc/apt/sources.list
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | apt-key add -

apt-get update
apt-get install -qy --no-install-recommends libreadline6-dev \
libcairo2-dev \
gfortran \
g++ \
unzip \
libboost-all-dev \
libpstreams-dev \
libtool \
r-base \
r-base-dev \
libblas-dev \
python3  \
python3-dev  \
python3-setuptools \
python3-pip \
