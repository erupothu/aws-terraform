
##### module in terraform


> mkdir payroll-app
> cat appserver.tf dynamodb_table.tf s3_bucket.tf variables.tf
> 
```module/aws_instnace.tf
resource "aws_instance" "webserver" {
  ami = "",
  type = "t2.micro
}
```

> mkdir us-payroll
> 
```us-payroll-app/main.tf

module "development" {
  source = "../prayroll-app
  app_region = "us-east-1
  ami = "i-09djaweqqwer923akd"
}
```

```uk-payroll-app/main.tf

module "development" {
  source = "../prayroll-app
  app_region = "us-east-1
  ami = "i-09djaweqqwer923akd"
}
```

```module/main.tf

module "security-group-ssh" {
  source = "terraform-aws-module/security-group/aws/module/ssh
  version = "3.6.2"
  vpc_id = ""
  ingress_cidr_block = ["10.10.0.0/16"]
  name = ""
}
```
> terraform get
> terraform console
> 
