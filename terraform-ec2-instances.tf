terraform {
  backend "remote" {
    organization = "organization_name"

    workspaces {
      name = "workspace_name"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}

resource "aws_instance" "webserver" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  user_data = <<-EOF
      #!/bin/bash
      sudo apt update
      sudo apt install nginx
      sudo systemctl enable nginx
      sudo systemctl start nginx
      EOF

  provisioner "local-exec" {
    on_failure = fail or continue
    command = "echo instance ${aws_instance.webserver.public_ip} created!" > /tmp/instance-state.txt"
  }

provisioner "local-exec" {
    when = destroy
    command = "echo instance ${aws_instance.webserver.public_ip} destroyed!" > /tmp/instance-state.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
  }
  connection {
    type = "ssh"
    host = self.public_ip
    user = "ubuntu"
    private_key = file(/root/.ssh/web)
  }

  key_name = aws_key_pair.web.id
  vpc_security_group_ids = [aws_security_group.ssh-access.id]
  tags = {
    Name = var.instance_name
    Description = "ec2 instance description"
  }
}

resource "aws_key_pair" "web" {
  public_key = file("/root/.ssh/web.pub")
}

resource "aws_security_group" "ssh-access" {
  name = "ssh-access"
  description = "allows ssh access from internet"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_block = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "eip" {
  vpc = true
  instance = aws_instance.cerberus.id
  provisioner "local-exec" {
      command = "echo public_dns ${aws_eip.eip.public_dns} created! > /root/cerberus_public_dns.txt"
  }
}

output "publicip" {
  value = aws_instance.webserver.public_ip
}
