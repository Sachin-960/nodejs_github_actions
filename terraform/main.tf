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
  default     = "mykey"
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "node_server" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2
  instance_type = "t2.micro"
  key_name      = var.key_name

  tags = {
    Name = "NodeJSServer"
  }

  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
}

resource "aws_security_group" "allow_ssh_http" {
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

output "public_ip" {
  value = aws_instance.node_server.public_ip
}