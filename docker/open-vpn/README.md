# Adding a new user - using docker (may not work in a windows environment)

## Dependencies
- Docker
- Team ansible vault password - Please ask for it to the administrator

## repo steps
## Step 1. Clone repo.
git clone git@github.com:eazsoftware/p915-aws-terraform.git
## Step 2 Create a branch for your username.
git checkout - b feature/adduser-YOURUSERNAME

## docker steps
## Step 3. Build docker image (within the same directory as this readme file, ../docker/open-vpn/), image contains required dependencies for google authenticator.
docker build -t open-vpn-add-credentials .
## Step 4. Run script on container (will mount this project in the container, so files can be modified and created outside the container, ready to be committed).
docker run -it -v /YOUR_PATH/p915-aws-terraform:/p915-aws-terraform open-vpn-add-credentials:latest /p915-aws-terraform/docker/open-vpn/open_vpn.sh

## commit and apply steps
## Step 5. Deploy.
Commit and push your changes in p915-aws-terraform
Raise a pull request and post it to the pull request channel
An admin member will deploy your changes (will run an ansible playbook with correct certs for you).

## test your access
## Step 6. Connect to open vpn (in ubuntu install extension to network, to add open-vpn as a connect type to the gui)
Use p915-aws-terraform/ansible/roles/openvpn/keys/clientTunnelBlick.ovpn to connect to the vpn by providing:
* your username
* your password

where your password is the password you entered in the script followed by the MAC authentication numbers given by google authenticator (yes do this every time).

## Step 7. Access to any other host inside of the internal network
