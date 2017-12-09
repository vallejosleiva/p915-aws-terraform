#!/bin/bash
set -e

ENVIRONMENT=$1
TERRAFORM_COMMAND=$2

if [[ $ENVIRONMENT != "dev" ]]; then
    echo "Unknown ENVIRONMENT parameter: [$ENVIRONMENT]"
    echo "Usage: ./infra-vpc-and-bastion.sh [dev] [apply|destroy]"
    exit 1
fi


echo "************************************************************************************************************************************************"

if [[ $TERRAFORM_COMMAND == "apply" ]]; then
    echo "Create Infrastructure and Provision one-vpc-bastion-only"
elif [[ $TERRAFORM_COMMAND == "destroy" ]]; then
    echo "Destroy Infrastructure one-vpc-bastion-only"
else
    echo "Unknown TERRAFORM_COMMAND parameter: [$TERRAFORM_COMMAND]"
    echo "Usage: ./infra-vpc-and-bastion.sh [dev] [apply|destroy]"
    exit 1
fi

echo "************************************************************************************************************************************************"


if [[ $TERRAFORM_COMMAND == "apply" ]]; then
    ./management_vpc.sh $ENVIRONMENT $TERRAFORM_COMMAND
    ./management_ec2.sh $ENVIRONMENT $TERRAFORM_COMMAND
else
    ./management_ec2.sh $ENVIRONMENT $TERRAFORM_COMMAND
    ./management_vpc.sh $ENVIRONMENT $TERRAFORM_COMMAND
fi
