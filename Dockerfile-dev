#FROM node:16.14.0-buster-slim
FROM ubuntu:20.04

ENV PURESCRIPT_VERSION 0.14.2

ARG UNAME=aryzach
ARG UID=1001
ARG GID=1001
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME

# packages for dev environment
RUN apt-get update 
RUN apt-get install -y sudo
RUN apt-get install -y git
RUN apt install -y tmux
RUN apt install -y vim
RUN apt install -y wget

# for node version (14.17.0) that works with needed purescript version (0.14.2)
RUN wget -qO- https://deb.nodesource.com/setup_14.x | sudo bash -
RUN apt install -y nodejs

# for purescript
RUN apt update \
    && apt install -y git libtinfo5 

RUN npm install -g purescript@$PURESCRIPT_VERSION --unsafe-perm 
RUN	npm install -g pulp
RUN	npm install -g bower 
#smoke tests
RUN purs --version 

RUN npm install -g http-server
RUN npm install -g purs-tidy

# setup env
USER aryzach
WORKDIR /home/aryzach/
RUN git clone https://github.com/aryzach/dotfiles.git
WORKDIR /home/aryzach/dotfiles
RUN /home/aryzach/dotfiles/setup.sh
WORKDIR /home/aryzach/
CMD /bin/bash -i "/home/aryzach/.bashrc"

# docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) -t purescript-snabbdom .
# docker run --net=host -itv `pwd`:/home/aryzach/purescript-snabbdom purescript-snabbdom /bin/bash
# docker start -i -a purescript-snabbdom


