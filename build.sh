#!/bin/bash -e
if [ "$IS_PULL_REQUEST" != true ]; then
  sudo docker build -t $IMAGE_NAME:$BRANCH.$BUILD_NUMBER .
  sudo docker tag -f $IMAGE_NAME:$BRANCH.$BUILD_NUMBER $IMAGE_NAME:$BRANCH.latest

else
  echo "skipping because it's a PR"
fi
