# Ghost Setup On Fargate

# Overview
Repository contains CloudFormation template and other resources to deploy Ghost blog stack in AWS Fargate.

Architecture: 
 ![](screenshots/Architecture_ghost.jpg)
 
Deploy Ghost service to the AWS cloud using AWS Fargate
1. Create ECR repository : 
    # ECR cloudformation stack
    $ ECR_STACK_NAME="ghost-on-aws-ecr"
    $ REGION="us-west-1"
    $ TAGS="Project=DeployGhostOnAWS"
    $ aws cloudformation deploy --region=$REGION --stack-name="$ECR_STACK_NAME" --template-file=./infrastructure/ecr.yaml --tags=$TAGS --no-fail-on-empty-changeset

    ![](screenshots/ecr_repository_create_cmd.png)
    
    ![](screenshots/ecr_ghost_aws_repository.png)

2. Build and deploy docker image
   $ chmod +x ./script/build-image.sh
   $ ./script/build-image.sh

    ![](screenshots/build-image-cmd.png)

3. Create VPC and deploy Ghost services
   
    ![](screenshots/deploy_ghost_aws.png)

