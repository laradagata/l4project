#!/bin/bash

# Install tcpdump
sudo apt install tcpdump

# Install curl
sudo apt install curl

# Install docker image
curl -sSL https://get.docker.com/ | sudo sh

# Update sudo
sudo apt-get update && sudo apt-get upgrade

# Install wireshark
sudo apt install wireshark
