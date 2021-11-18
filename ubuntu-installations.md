
#### install AWS Client
* sudo apt install aws-cli 
* aws --version
* aws configure (access key + secret key)
* nano ~/.aws/credentials (check config credentials)

#### Install Terraform
* sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
* curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
* sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
* sudo apt-get update && sudo apt-get install terraform
* terraform --version

### Install Helm
* curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
* sudo apt-get install apt-transport-https --yes
* echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
* sudo apt-get update
* sudo apt-get install helm


