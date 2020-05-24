FROM ubuntu:16.04 
RUN apt-get update
RUN apt-get install autoconf curl wget git cmake libncurses5-dev python-dev python3-dev \
                    ruby-dev lua5.1 lua5.1-dev ctags -y
ADD . /usr/src/
RUN /bin/bash -c "cd /usr/src/ && source install.sh"
