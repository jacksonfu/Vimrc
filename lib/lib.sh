#!/bin/bash

set -e

export PREFIX=$HOME
export VIMPATH=$HOME/.vim
export TMP=$HOME/.vim.git
export PROFILE=$HOME/.profile
export BIN=$HOME/bin

mkdir -p $TMP
mkdir -p $VIMPATH
mkdir -p $BIN
test ! -f $PROFILE && touch $PROFILE || echo -n

download() {
    url=$1
    filename=$2
    if [ ! -f "$filename" ]; then
        message "----> Download $filename"
        wget $url -O $filename
        message "====> Download $filename Success"
    else
        echo '$filename exists, continue'
    fi
}

message() {
    echo -e "\033[32m$@\033[0m"
}

error() {
    echo -e "\033[31m$@\033[0m"
}

getMakeFlag()
{
    Counts=$(grep 'physical id' /proc/cpuinfo |sort |uniq |wc -l)  # CPU核数
    __makeflags="-j$Counts"
    export MAKEFLAGS=$__makeflags
    message "set MAKEFLAGS=$MAKEFLAGS"
}

version_ge()
{
    test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" == "$1";
}

