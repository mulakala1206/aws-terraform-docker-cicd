########################################
# Fetch latest Amazon Linux 2 AMI
########################################

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

########################################
# Security Group (SSH + HTTP)
########################################

resource "aws_security_group" "web_sg" {
  name        = "terraform-web-sg"
  description = "Allow SSH and HTTP traffic"

  # SSH Access
  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP Access
  ingress {
    description = "HTTP Access"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-security-group"
  }
}

########################################
# EC2 Instance (Free Tier eligible)
########################################

resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]

  user_data = file("${path.module}/scripts/install_docker.sh")

  tags = {
    Name = "terraform-ec2-instance"
  }
}