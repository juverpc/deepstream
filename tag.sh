#!/bin/bash

CSV=${1:-'tags_name.csv'}
ECR_URL="public.ecr.aws/s5w6j9m1"
ECR_REPO_NAME="deepstream-poc"

#for i in sagemaker-safety-image sagemaker-fnb-image 
for i in $(cat ${CSV} | grep -v '#')
do
docker tag ${ECR_REPO_NAME}:${i} ${ECR_URL}/${ECR_REPO_NAME}:${i}
done

# docker tag deepstream-poc:latest public.ecr.aws/s5w6j9m1/deepstream-poc:latest