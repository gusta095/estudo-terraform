#!/bin/bash

# Install Docker
sudo apt-get update
sudo curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker ubuntu
