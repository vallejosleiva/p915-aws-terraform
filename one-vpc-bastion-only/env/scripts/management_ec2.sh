#!/bin/bash
set -e

ENVIRONMENT=$1
TERRAFORM_COMMAND=$2

if [[ $ENVIRONMENT != "dev" ]]; then
    echo "Unknown ENVIRONMENT parameter: [$ENVIRONMENT]"
    echo "Usage: ./management_ec2.sh [dev] [plan|apply|destroy]"
    exit 1
fi

echo "************************************************************************************************************************************************"

if [[ $TERRAFORM_COMMAND == "apply" ]]; then
    echo "Create Bastion Management EC2"
    ACTION="create"
elif [[ $TERRAFORM_COMMAND == "plan" ]]; then
    echo "Plan Bastion Management EC2"
    ACTION="plan"
elif [[ $TERRAFORM_COMMAND == "destroy" ]]; then
    echo "Destroy Bastion Management EC2"
    ACTION="destroy"
else
    echo "Unknown TERRAFORM_COMMAND parameter: [$TERRAFORM_COMMAND]"
    echo "Usage: ./management_ec2.sh [dev] [plan|apply|destroy]"
    exit 1
fi

echo "************************************************************************************************************************************************"

function ask_for_confirmation {
    while [[ ! $CREATION_CONTINUE == "IMSURE" ]]
    do
        echo "This script will $ACTION one bastion ec2 instance, enter 'IMSURE' to continue"
        read CREATION_CONTINUE
    done
}

function cleanup_local_terraform_state {
    rm -rf .terraform
    rm -f terraform.tfstate
    rm -f terraform.tfstate.backup
}

if [[ $TERRAFORM_COMMAND != "plan" ]]; then
    ask_for_confirmation
fi

cd ../$ENVIRONMENT/ec2/bastion

cleanup_local_terraform_state

terraform init

if [[ $TERRAFORM_COMMAND == "destroy" ]]
then
    yes yes | terraform $TERRAFORM_COMMAND
else
    terraform $TERRAFORM_COMMAND
fi

