#!/usr/bin/env bash

if [ -z $1 ]; then
   echo "Enter environment name used when provisioning with terraform. i.e. main or your developer environment name"
   read ENV
   ENV=$ENV
else
   ENV=$1
fi

ansible-playbook -i "192.168.99.100," -u ubuntu ../../ansible/playbooks/openvpn_playbook.yml --extra-vars="ENV=$ENV" --skip-tag "destroy" --ask-vault-pass

