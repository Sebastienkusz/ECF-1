#! /bin/sh
set -xe

apt-get update
apt-get install -y curl openssh-server ca-certificates tzdata perl
