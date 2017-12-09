#!/bin/bash
set -e

ENVIRONMENT=$1
TERRAFORM_COMMAND=$2

if [[ $ENVIRONMENT != "dev" ]]; then
    echo "Unknown ENVIRONMENT parameter: [$ENVIRONMENT]"
    echo "Usage: ./management_vpc.sh [dev] [plan|apply|destroy]"
    exit 1
fi


echo "************************************************************************************************************************************************"

if [[ $TERRAFORM_COMMAND == "apply" ]]; then
    echo "Create Management VPC"
elif [[ $TERRAFORM_COMMAND == "plan" ]]; then
    echo "Plan Management VPC"
elif [[ $TERRAFORM_COMMAND == "destroy" ]]; then
    echo "Destroy Management VPC"
else
    echo "Unknown TERRAFORM_COMMAND parameter: [$TERRAFORM_COMMAND]"
    echo "Usage: ./management_vpc.sh [dev] [plan|apply|destroy]"
    exit 1
fi

echo "************************************************************************************************************************************************"

function cleanup_local_terraform_state {
    rm -rf .terraform
    rm -f terraform.tfstate
    rm -f terraform.tfstate.backup
}

cd ../$ENVIRONMENT/vpc/fixed

cleanup_local_terraform_state

terraform init

if [[ $TERRAFORM_COMMAND == "destroy" ]]
then
    yes yes | terraform $TERRAFORM_COMMAND
else
    terraform $TERRAFORM_COMMAND
fi
