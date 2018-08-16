#!/bin/bash

# Added for ubuntu 18, universe was not enabled after fresh install
add-apt-repository universe

apt-get update && apt-get upgrade -y

apt-get install -y python-minimal build-essential libssl-dev libffi-dev python-dev python-markupsafe python-pip

pip install --upgrade setuptools

pip install ansible

