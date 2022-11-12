#!/bin/bash
set -x
docker build -t pico-sigrok --build-arg CONTAINER_USER_ID=$UID --build-arg CONTAINER_USER_NAME=$USERNAME .