#!/bin/bash

CSV=${1:-'tags_name.csv'}
ECR_URL="624733648801.dkr.ecr.us-east-1.amazonaws.com"
ECR_REPO_NAME="deepstream-poc"

for i in $(cat ${CSV} | grep -v '#')
do
docker push public.ecr.aws/s5w6j9m1/${ECR_REPO_NAME}:${i}
done
