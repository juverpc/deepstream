#!/bin/bash

CSV=${1:-'tags_name.csv'}
ECR_URL="624733648801.dkr.ecr.us-east-1.amazonaws.com"
ECR_REPO_NAME="demo"

for i in $(cat ${CSV} | grep -v '#')
do
docker push ${ECR_URL}/${ECR_REPO_NAME}:${i}
done
