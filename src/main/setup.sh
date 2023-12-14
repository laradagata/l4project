#!/bin/bash

# Install setup and dependencies 
sudo apt install tcpdump
sudo apt install curl

sudo apt-get update && sudo apt-get upgrade
sudo apt install wireshark

sudo apt update
sudo apt -y install gcc
sudo apt -y install cmake
sudo apt -y install g++
sudo apt install cargo

# Install docker image
curl -sSL https://get.docker.com/ | sudo sh

# Install rust compiler
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# Download Quiche project
cd $HOME && git clone --recursive https://github.com/cloudflare/quiche 

# Build Quiche
cd $HOME/quiche && cargo build --examples

# Verify installation
cd $HOME/quiche && cargo test
