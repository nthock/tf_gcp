#!/bin/bash
docker run \
  --env POSTGRES_DB=dpoinbox \
  --env POSTGRES_USER=dpoinbox \
  --env POSTGRES_PASSWORD=dpoinbox \
  --volume database-data:/var/lib/postgresql/data/ \
  --volume ./database.sql:/docker-entrypoint-initdb.d/init.sql \
  postgres:12.1-alpine 
# sudo curl -sSL https://get.docker.com/ | sh
# sudo usermod -aG docker `echo $USER`
# sudo docker run -d -p 80:80 nginx