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
RUN export DEBIAN_FRONTEND=noninteractive \
	&& apt-get update && yes|apt-get upgrade \
	&& apt-get -y install apt-utils \
	&& apt-get -y install rlwrap \
	&& apt-get -y install git \
	&& apt-get -y install wget \
	&& apt-get -y install bzip2 \
	&& apt-get -y install sudo \
	&& apt-get -y install wget \
	&& apt-get -y install curl \
	&& apt-get -y install vim \
	&& apt-get -y install gcc \
	&& apt-get -y install g++ \
	&& rm -rf /var/lib/apt/lists/* \
	&& wget https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh -O LFSInstall.sh \
	&& export DEBIAN_FRONTEND=noninteractive \
	&& apt-get update && yes|apt-get upgrade \
	&& apt-get install -y gnupg \
	&& bash ./LFSInstall.sh \
	&& apt-get install git-lfs \
	&& git lfs install \
	#-----#
	# create and set to user foorx
	&& adduser --disabled-password --gecos '' foorx \
	&& adduser foorx sudo \
	&& echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER foorx
#-----#
# set working directory of user foorx
WORKDIR /home/foorx
RUN chmod a+rwx /home/foorx \
	#-----#
	# install Anaconda3
	&& wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh \
	&& bash Anaconda3-2020.02-Linux-x86_64.sh -b \
	&& rm -f Anaconda3-2020.02-Linux-x86_64.sh
#-----#
# Set path to conda
ENV PATH /home/foorx/anaconda3/bin:$PATH
#-----#
# Updating Anaconda packages
RUN conda update conda \
	&& conda update anaconda \
	&& conda update --all \
	#-----#
	# Configuring access to Jupyter
	&& mkdir /home/foorx/notebooks \
	&& jupyter notebook --generate-config --allow-root \
	&& echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /home/foorx/.jupyter/jupyter_notebook_config.py \
	#-----#
	# install kdb!
	&& conda install -c kx kdb \
	&& conda install -c kx embedpy \
	&& conda install -c kx jupyterq 
#-----#
ENV PATH=$PATH:/home/foorx/anaconda3/q/l64
ENV QHOME=/home/foorx/anaconda3/q
COPY --chown=foorx ./assets/kc.lic /home/foorx/anaconda3/q/kc.lic

# install python requirements
COPY --chown=foorx ./assets/requirements.txt /home/foorx/requirements.txt
RUN python3 -m pip install -r ~/requirements.txt && rm ~/requirements.txt

# copy assets
COPY --chown=foorx ./assets/ /home/foorx/

RUN mv ~/ml ~/anaconda3/q/ \
	# clone OHR400 repo
	# && cd ~/Sites && git clone https://github.com/foorenxiang/OHR400Dashboard \
	# create logs folder
	&& mkdir ~/logs \
	&& echo "cd ~/Sites/OHR400Dashboard" >> /home/foorx/.bashrc \
	#-----#
	# Set vim as editor
	&& echo "export EDITOR=vim" >> /home/foorx/.bashrc \
	# double check order of pip install and git pull if something goes wrong in production branch
	&& git config --global user.email "foorenxiang@gmail.com" \
	&& git config --global user.name "foorenxiang" \
	&& git lfs install


COPY --chown=foorx ./entrypoint.sh ~/entrypoint.sh

ENTRYPOINT ["~/entrypoint.sh"]
