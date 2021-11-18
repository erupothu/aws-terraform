
### Terraform Core concepts
#### Variables: 
* Also used as input-variables, it is key-value pair used by Terraform modules to allow customization.
#### Provider: 
* It is a plugin to interact with APIs of service and access its related resources.
#### Module: 
* It is a folder with Terraform templates where all the configurations are defined
#### State: 
* It consists of cached information about the infrastructure managed by Terraform and the related configurations.
#### Resources: 
* It refers to a block of one or more infrastructure objects (compute instances, virtual networks, etc.), which are used in configuring and managing the infrastructure.
#### Data Source: 
* It is implemented by providers to return information on external objects to terraform.
#### Output Values: 
* These are return values of a terraform module that can be used by other configurations.
#### Plan: 
* It is one of the stages where it determines what needs to be created, updated, or destroyed to move from real/current state of the infrastructure to the desired state.
#### Apply: 
* It is one of the stages where it applies the changes real/current state of the infrastructure in order to move to the desired state.

### Terraform Lifecycle
* Terraform lifecycle consists of – init, plan, apply, and destroy.
* Terraform init initializes the working directory which consists of all the configuration files
* Terraform plan is used to create an execution plan to reach a desired state of the infrastructure. Changes in the configuration files are done in order to achieve the desired state.
* Terraform apply then makes the changes in the infrastructure as defined in the plan, and the infrastructure comes to the desired state.
* Terraform destroy is used to delete all the old infrastructure resources, which are marked tainted after the apply phase.
