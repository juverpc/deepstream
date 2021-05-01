#!/bin/bash

CSV=${1:-'tags_name.csv'}
ECR_URL="public.ecr.aws/s5w6j9m1"
ECR_REPO_NAME="deepstream-poc"

for i in $(cat ${CSV} | grep -v '#')
do
docker push ${ECR_URL}/${ECR_REPO_NAME}:${i}
done

# docker push public.ecr.aws/s5w6j9m1/deepstream-poc:latest