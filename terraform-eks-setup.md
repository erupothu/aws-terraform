### Prerequisites:
* Prerequisites
	* AWS Account (Cloud Infrastructure As Service IAS)
	* Terraform Account (Infrastructure Management As Code IAC)
	* Docker Hub Account (Docker Containers and Images management)
	* GitHub Account (Code Management & version Control)
	* Helm Account (Apps Management)

* Local Machine Installs
	* AWS CLI (Manage AWS Cloud Services from Local) -- `apt install awscli` and `apt install aws-iam-authenticator`
	* Terraform (Manage Cloud Service from Local Code Setup .tf files)
	* Kuberantes (Manage Cloud Apps from Local commands) `install kubernetes-cli`
	* Docker (Manage Cloud Docker containers and Images from Local commands)
	* Helm (Manage Cloud Apps from Local Helm Charts)

#### Working Process Verified (working)
* git clone https://github.com/hashicorp/learn-terraform-provision-eks-cluster # GIT URL
* cd learn-terraform-provision-eks-cluster
* terraform init
* terraform apply
* aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name) # Configure kubectl
* wget -O v0.3.6.tar.gz https://codeload.github.com/kubernetes-sigs/metrics-server/tar.gz/v0.3.6 && tar -xzf v0.3.6.tar.gz # Deploy Kubernetes Metrics Server
* kubectl apply -f metrics-server-0.3.6/deploy/1.8+/
* kubectl get deployment metrics-server -n kube-system
* kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml # Deploy Kubernetes Dashboard
* kubectl apply -f https://raw.githubusercontent.com/hashicorp/learn-terraform-provision-eks-cluster/master/kubernetes-dashboard-admin.rbac.yaml # Authenticate the dashboard
* kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep service-controller-token | awk '{print $1}')
* kubectl proxy
* terraform destroy
