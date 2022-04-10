#!/usr/bin/env bash

# check if required input was provided
if [ $# == 0 ] | [ -z "$0" ]; then
  echo "Invalid input parameter !"
  exit 1
fi

# general stack properties
REGION="us-west-1"
TAGS="Project=DeployGhostOnAWS"

# container scale properties
DESIRED_COUNT=1
CONTAINER_CPU=256
CONTAINER_MEMORY=512

# Paste image URL arn below
IMAGE_URL="<ECR ARN>/ghost-on-aws-ecr:latest" 

# Input prefix from command line
PREFIX="$1"

# ECR cloudformation stack
ECR_STACK_NAME="${PREFIX}-ecr"
aws cloudformation deploy \
  --region=$REGION \
  --stack-name="$ECR_STACK_NAME" \
  --template-file=./infrastructure/ecr.yaml \
  --tags=$TAGS \
  --no-fail-on-empty-changeset

# VPC cloudformation stack  
VPC_STACK_NAME="${PREFIX}-vpc"
aws cloudformation deploy \
  --region=$REGION \
  --stack-name="$VPC_STACK_NAME" \
  --template-file=./infrastructure/vpc.yaml \
  --capabilities=CAPABILITY_IAM \
  --no-fail-on-empty-changeset

# ghost web service stack
WEB_STACK_NAME="${PREFIX}-web"
aws cloudformation deploy \
  --stack-name="$WEB_STACK_NAME" \
  --template-file=./infrastructure/service.yaml \
  --no-fail-on-empty-changeset \
  --parameter-overrides \
  StackName="$VPC_STACK_NAME" \
  ServiceName=web \
  ImageUrl="$IMAGE_URL" \
  DesiredCount=$DESIRED_COUNT \
  ContainerCpu=$CONTAINER_CPU \
  ContainerMemory=$CONTAINER_MEMORY \
  ContainerPort=2368