# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

# Define required variables
variable "access_key" {
  description = "AWS Access Key ID"
  type        = string
}

variable "secret_key" {
  description = "AWS Secret Access Key"
  type        = string
}

variable "key_name" {
  description = "SSH key name in AWS"
  type        = string
}

# Try to find an existing security group by name
data "aws_security_group" "existing_sg" {
  name = "allow_ssh_http"
}

# Create the security group only if it doesn't exist
resource "aws_security_group" "dynamic_sg" {
  count = data.aws_security_group.existing_sg.id == "" ? 1 : 0

  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Use the existing SG ID or fall back to the newly created one
locals {
  # Handle count-based access for dynamic_sg
  sg_id = data.aws_security_group.existing_sg.id != "" ? data.aws_security_group.existing_sg.id : aws_security_group.dynamic_sg[0].id
}

# Launch EC2 Instance
resource "aws_instance" "node_server" {
  ami           = "ami-0953476d60561c955" # Ubuntu 22.04 AMI in us-east-1
  instance_type = "t2.micro"
  key_name      = var.key_name
  vpc_security_group_ids = [local.sg_id]

  tags = {
    Name = "NodeJSServer"
  }
}

# Output Public IP
output "public_ip" {
  value = aws_instance.node_server.public_ip
}