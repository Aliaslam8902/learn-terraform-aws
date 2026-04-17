terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

# Get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Create a simple EC2 instance (Free Tier eligible)
resource "aws_instance" "my_first_vm" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t3.micro"

  tags = {
    Name = "Ali-First-VM"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              echo "Hello from Terraform!" | sudo tee /usr/share/nginx/html/index.html
              EOF
}

# Output the public IP for reference
output "instance_public_ip" {
  value = aws_instance.my_first_vm.public_ip
}
