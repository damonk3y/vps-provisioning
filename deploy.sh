#! /bin/bash

export $(cat .env) > /dev/null 2>&1;
docker stack deploy --with-registry-auth -d -c docker-compose.yml beyoutique