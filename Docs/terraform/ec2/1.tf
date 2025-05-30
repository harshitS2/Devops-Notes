terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

# 🔐 Security group to allow SSH and Jenkins
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH and Jenkins access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # SSH from any IP (not secure for prod!)
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Jenkins default port
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 🔑 Key pair (make sure my-ec2-key.pub exists in the same directory)
resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = file("${path.module}/my-ec2-key.pub")
}

# 💻 EC2 instance with Jenkins setup
resource "aws_instance" "app_server" {
  ami                    = "ami-04f167a56786e4b09" # Ubuntu 22.04 LTS in us-east-2
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  user_data = <<EOF
#!/bin/bash
apt-get update -y
apt-get install -y openjdk-11-jdk gnupg2 curl

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | gpg --dearmor -o /usr/share/keyrings/jenkins-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.gpg] https://pkg.jenkins.io/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list

apt-get update -y
apt-get install -y jenkins

systemctl enable jenkins
systemctl start jenkins
EOF

  tags = {
    Name = "JenkinsServer"
  }
}

# 🌐 Output the instance public IP
output "public_ip" {
  value = aws_instance.app_server.public_ip
}