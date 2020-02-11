#!/bin/bash
sudo curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker `echo $USER`
sudo docker run -d -p 80:80 nginx