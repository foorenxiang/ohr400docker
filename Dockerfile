# Declare the anaconda linux base image
FROM ubuntu:18.04

# expose ports
EXPOSE  5001
EXPOSE  6001
EXPOSE  6002
EXPOSE  80
EXPOSE	3000
EXPOSE	3001
EXPOSE	5000

# run any installs required
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get -y install apt-utils
RUN apt-get -y install rlwrap
RUN apt-get -y install iputils-ping
RUN apt-get -y install git
RUN apt-get -y install wget
RUN apt-get -y install curl

# install conda
# ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# ENV PATH /opt/conda/bin:$PATH
# # ENV PATH /home/foorx/conda/bin:$PATH

# RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
#     libglib2.0-0 libxext6 libsm6 libxrender1 \
#     git mercurial subversion

# RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda2-4.5.11-Linux-x86_64.sh -O ~/miniconda.sh && \
#     /bin/bash ~/miniconda.sh -b -p /opt/conda && \
#     rm ~/miniconda.sh && \
#     ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
#     echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
#     echo "conda activate base" >> ~/.bashrc

# RUN apt-get install -y curl grep sed dpkg && \
#     TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
#     curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
#     dpkg -i tini.deb && \
#     rm tini.deb && \
#     apt-get clean


# COPY ./miniconda.sh /home/foorx/miniconda.sh
RUN mkdir /home/foorx
RUN chown -R 999:999 /home/foorx

# create new user foorx
RUN groupadd -r mygrp && useradd -r -g mygrp foorx

# set to user foorx
USER foorx

# set working directory of user foorx
WORKDIR /home/foorx

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /home/foorx/miniconda.sh
RUN bash /home/foorx/miniconda.sh -b -p ~/miniconda

# RUN cd /home/foorx/Sites && git clone https://github.com/foorenxiang/OHR400Dashboard
# RUN cd /home/foorx/Sites/OHR400Dashboard && git pull

#64bit q QHOME
ENV PATH=$PATH:/home/foorx/l64/l64
ENV QHOME=/home/foorx/l64
# ENV q="rlwrap /home/foorx/l64/l64/q"

# RUN conda install -c kx kdb 

# COPY ./dockermountUbuntu /home/foorx/

# ENTRYPOINT ["/entrypoint.sh"]