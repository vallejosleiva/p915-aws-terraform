#!/usr/bin/env bash

if [ -z $1 ]; then
   echo "Enter your username"
   read USERNAME
else
   USERNAME=$1
fi

google-authenticator -t -f -d --qr-mode=ANSI -r 3 -R 30 -w 1 --secret="/p915-aws-terraform/ansible/roles/openvpn/keys/googleAuthenticator/"$USERNAME"_google_authenticator"
chmod 777 "/p915-aws-terraform/ansible/roles/openvpn/keys/googleAuthenticator/"$USERNAME"_google_authenticator"
ansible-vault encrypt "/p915-aws-terraform/ansible/roles/openvpn/keys/googleAuthenticator/"$USERNAME"_google_authenticator" --ask-vault-pass
HASHED_PASSWORD=$(python -c "from passlib.hash import sha512_crypt; import getpass; print sha512_crypt.encrypt(getpass.getpass())") # >> /conf/hashed_open_vpn_password.txt

USER="- user: name="$USERNAME" password="$HASHED_PASSWORD" groups=sudo,developers shell=/bin/bash"
sed -i '/system=yes/a\
\ \ \ \ '"$USER"'
' /p915-aws-terraform/ansible/playbooks/openvpn_playbook.yml