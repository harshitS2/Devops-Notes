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

}
user_data = <<EOF
#!/bin/bash
set -e
# Retry apt-get update to handle transient network issues
for i in {1..5}; do
  apt-get update -y && break
  sleep 10
done
# Install dependencies
apt-get install -y fontconfig openjdk-11-jdk wget
# Verify Java version
java -version
# Install Jenkins
if ! dpkg -l | grep -q jenkins; then
  wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
  echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | tee /etc/apt/sources.list.d/jenkins.list > /dev/null
  for i in {1..5}; do
    apt-get update -y && break
    sleep 10
  done
  apt-get install -y jenkins
fi
# Start and enable Jenkins
systemctl enable jenkins
systemctl start jenkins
EOF

  tags = {
    Name = "JenkinsServer"
  }

# 🌐 Output the instance public IP
output "public_ip" {
  value = aws_instance.app_server.public_ip
}