#!/usr/bin/env bash

# This preps our Python3 environment so we can configure our aggregator, provider, sets, etc.

echo "Install and Update Pip"
sudo apt install python3-pip
pip3 install --upgrade pip

echo "Install Python Libraries"
pip3 install requests
pip3 install pyyaml

echo "Create Aggregators, Providers, Datasets, and Harvest!"

