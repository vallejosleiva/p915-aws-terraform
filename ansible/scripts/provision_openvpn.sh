#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $CURRENT_DIR

if [ -z $1 ]; then
   echo "Enter environment name used when provisioning with terraform. i.e. main or your developer environment name"
   read ENV
   ENV=$ENV
else
   ENV=$1
fi

bastion_openvpn_server_ip=$($CURRENT_DIR/boto-scripts/determine-bastion-host-from-route53.py $ENV $active_env_type)

if [[ -z $bastion_openvpn_server_ip || $bastion_openvpn_server_ip == "None" ]]
then
    echo "Unable to determine bastion server ip, got '$bastion_openvpn_server_ip' instead"
    exit 1
fi

echo "***********************************************************************"
echo "Provisioning bastion openvpn server [$bastion_openvpn_server_ip]"
echo "***********************************************************************"
#ansible-playbook -i "192.168.99.100," -u ubuntu ../../ansible/playbooks/openvpn_playbook.yml --extra-vars="ENV=$ENV" --skip-tag "destroy" --ask-vault-pass
#ansible-playbook -i "ip.ip.ip.ip," -u ubuntu ../../ansible/playbooks/openvpn_playbook.yml --extra-vars="ENV=$ENV" --skip-tag "destroy" --ask-vault-pass
#ansible-playbook -i "openvpn.javallejos.com," -u ubuntu ../../ansible/playbooks/openvpn_playbook.yml --extra-vars="ENV=$ENV" --skip-tag "destroy" --ask-vault-pass
ansible-playbook -i "$bastion_openvpn_server_ip," -u ubuntu $CURRENT_DIR/../playbooks/openvpn_playbook.yml --extra-vars="ENV=$ENV" --skip-tag "destroy" --ask-vault-pass