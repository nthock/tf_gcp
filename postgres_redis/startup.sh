#!/bin/bash

# Install Postgres and Redis
echo "current user: $USER"
echo "current directory: $PWD"

echo "update"
sudo apt-get update

echo "install postgres and redis"
sudo apt-get -y --no-install-recommends install postgresql postgresql-client postgresql-contrib redis-server


echo "current directory: $PWD"
echo "running sudo -s"
sudo -s
echo "current directory: $PWD"
echo "current user: $USER"

# Create the database
echo "creating database"
sudo -u postgres createdb dpoinbox

# Create the user
echo "create user"
sudo -u postgres createuser dpoinbox

# Download the database.sql to the instance
echo "downloading database.sql..."
gsutil cp gs://dpoinbox_bucket/database.sql .

# Load the data into the DB
echo "loading database.sql to dpoinbox"
sudo -u postgres psql dpoinbox < database.sql

# sudo -u postgres psql
# \list
# \c dpoinbox
# \dt

# Docker
echo "running docker"
sudo curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker `echo $USER`
sudo docker run -d -p 80:80 nginx