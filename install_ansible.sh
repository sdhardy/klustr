#!/bin/bash

apt-get update && apt-get upgrade -y

apt-get install -y python-minimal build-essential libssl-dev libffi-dev python-dev python-markupsafe python-pip

pip install --upgrade setuptools

pip install ansible

