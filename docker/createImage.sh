#!/bin/bash

if [ -z $1 ]; then
   echo "please enter your repo name e.g. eaz.service.helloworld or ubuntu"
   read $FOLDER
else
   FOLDER=$1
fi

if [ -z $2 ]; then
   echo "Please enter your numeric AWS account id e.g. 491000000000"
   read ACCOUNT_ID
else
   ACCOUNT_ID=$2
fi

if [ -z $3 ]; then
   echo "please enter your AWS region"
   read REGION
else
   REGION=$3
fi

if [ -z $4 ]; then
   echo "please enter your image name e.g. eaz.service.helloworld or ubuntu"
   read IMAGE_NAME
else
   IMAGE_NAME=$4
fi

if [ -z $5 ]; then
   echo "please enter your image version e.g. 1.0 or 1.0-SNAPSHOT region"
   read IMAGE_VERSION
else
   IMAGE_VERSION=$5
fi

aws ecr get-login --region $REGION > docker_login.sh
chmod 700 docker_login.sh
./docker_login.sh
rm docker_login.sh

cd $FOLDER

if [ -f "./preTask.sh" ]; then
    ./preTask.sh
fi

docker build . --tag $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$IMAGE_NAME:$IMAGE_VERSION --file Dockerfile

if [ -f "./postTask.sh" ]; then
    ./postTask.sh
fi