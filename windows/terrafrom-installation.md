
#### Setup in windows
1. https://developer.hashicorp.com/terraform/downloads  
2. Download and set environment variable to terraform exe file  

> terraform version  

```block.terraform
<block_name> <block_type> <block_name> {
  key1 = value1
  key2 = value2
}

resource "local_file" "pet" {
  filename = "/root/myfile.txt"
  content = "we love pets"
}

resource "aws_instance" "webserver" {
  ami = "ami_id"
  instance_type = "t2.micro"
}

resource "aws_s3_bucket" "finance" {
  bucket = "webserver-bucket"
  acl = "private"
}

```

> terraform init  
> terraform plan  
> terraform apply  
> terraform show  
> terraform destroy
> 
