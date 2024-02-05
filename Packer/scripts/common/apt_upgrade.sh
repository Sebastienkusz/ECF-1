#! /bin/sh
set -xe

export DEBIAN_FRONTEND=noninteractive
apt-get -q update
apt-get -qy upgrade