#!/usr/bin/env bash
#Script perform following :
#1. loggin to aws
#2. Build docker image
#3. Tag image with ECR 
#4. Push to ECR

#aws loggin set
aws ecr get-login-password --region us-west-1 | docker login --username AWS --password-stdin <ECR ARN>
# Build docker image
docker build -t ghost-on-aws-ecr .
# Tag image with ecr registry
docker tag ghost-on-aws-ecr:latest <ECR ARN>/ghost-on-aws-ecr:latest
# Push image to AWS ECR
docker push <ECR ARN>/ghost-on-aws-ecr:latest
