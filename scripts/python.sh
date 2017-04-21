#!/usr/bin/env bash

# This preps our Python3 environment so we can configure our aggregator, provider, sets, etc.

echo "Install and Update Pip"
sudo -H apt-get install -y python3-pip
sudo -H pip3 install --upgrade pip

echo "Install Python Libraries"
sudo -H pip3 install requests
sudo -H pip3 install pyyaml

echo "Create Aggregators, Providers, Datasets, and Harvest!"
python3 /vagrant/scripts/custom_python/swagger.py
