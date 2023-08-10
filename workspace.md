

#### create workspace

> terraform workspace new projectA
> terraform workspace list
> terraform workspace projectB


```variables.tf
variable "region" {
  default = "ap-south-1
}
variable "instance_type" {
  default = "t2.micro"
}
variable "ami" {
  type = map(string)
  default = {
    "projectA" = "i-12ldfalewrqeq23df"
    "projectB" = "i-013adfew3243"
  }
}
```

```main.tf
resource "aws_instance" "porjectA" {
  ami = lookup(var.ami, terraform.workspace)
  instance_type = var.instance_type
  tags = [
    Name = terraform.workspace
  }
}
```
> terraform workspace select projectA
> terraform apply
> tree terraform.tfstate.d
> 
