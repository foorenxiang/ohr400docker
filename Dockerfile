# http://www.science.smith.edu/dftwiki/index.php/Tutorial:_Docker_Anaconda_Python_--_4#towardsDataScience:_Not_Reinventing_the_Wheel
# https://github.com/nodejs/docker-node/issues/740
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
EXPOSE	8888

# run any installs required
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update && yes|apt-get upgrade \
	&& apt-get -y install apt-utils \
	&& apt-get -y install rlwrap \
	&& apt-get -y install git \
	&& apt-get -y install wget \
	&& apt-get -y install curl \
	&& apt-get -y install bzip2 \
	&& apt-get -y install sudo \
	&& apt-get install -y wget \
	&& rm -rf /var/lib/apt/lists/*

# create and set to user foorx
RUN adduser --disabled-password --gecos '' foorx
RUN adduser foorx sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER foorx

# set working directory of user foorx
WORKDIR /home/foorx
RUN chmod a+rwx /home/foorx

# install Anaconda3
RUN wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh \
	&& bash Anaconda3-2020.02-Linux-x86_64.sh -b \
	&& rm -f Anaconda3-2020.02-Linux-x86_64.sh

# Set path to conda
ENV PATH /home/foorx/anaconda3/bin:$PATH

# Updating Anaconda packages
RUN conda update conda
RUN conda update anaconda
RUN conda update --all

# Configuring access to Jupyter
RUN mkdir /home/foorx/notebooks
RUN jupyter notebook --generate-config --allow-root
RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /home/foorx/.jupyter/jupyter_notebook_config.py

# install kdb!
RUN conda install -c kx kdb 
RUN conda install -c kx embedpy 
RUN conda install -c kx jupyterq 
ENV PATH=$PATH:/home/foorx/anaconda3/q/l64
ENV QHOME=/home/foorx/anaconda3/q
COPY --chown=foorx ./assets/kc.lic /home/foorx/anaconda3/q/kc.lic

# copy assets
COPY --chown=foorx ./assets/ /home/foorx/

# clone OHR400 repo
RUN cd ~/Sites && git clone https://github.com/foorenxiang/OHR400Dashboard
CMD cd ~/Sites/OHR400Dashboard && git pull

# ENTRYPOINT ["/entrypoint.sh"]