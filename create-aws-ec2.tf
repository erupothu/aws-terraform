provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}

vaiable "aws property"

resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}
