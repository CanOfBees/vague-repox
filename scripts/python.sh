#!/usr/bin/env bash

# Install Needed Packages for Python3.7 on 16.04
sudo apt-get install -y checkinstall
sudo apt-get install -y libreadline-gplv2-dev
sudo apt-get install -y libncursesw5-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y libsqlite3-dev
sudo apt-get install -y tk-dev
sudo apt-get install -y libgdbm-dev
sudo apt-get install -y libbz2-dev
sudo apt-get install -y openssl
sudo apt-get install -y libffi-dev

# Install Python3.7
sudo mkdir /tmp/Python37
sudo cd /tmp/Python37
sudo wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tar.xz
sudo wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tar.xz
sudo tar xvf Python-3.7.0.tar.xz
sudo cd /tmp/Python37/Python-3.7.0
sudo ./configure --enable-optimizations
sudo make altinstall

# This preps our Python3 environment so we can configure our aggregator, provider, sets, etc.

echo "Install and Update Pip"
sudo -H apt-get install -y python3-pip
sudo -H pip3 install --upgrade pip

# Install Pipenv

pip3 install --user pipenv
export PATH="$HOME/.local/bin:$PATH"
source ~/.profile

echo "Install Python Libraries"
sudo -H pip3 install requests
sudo -H pip3 install pyyaml

echo "Create Aggregators, Providers, Datasets, and Harvest!"
python3 /vagrant/scripts/custom_python/swagger.py

# Install Pyrepox
cd /home/vagrant
mkdir pyrepox_testing
cd /home/pyrepox_testing
pipenv --python 3.7 install
pipenv shell
pip install --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple repox
