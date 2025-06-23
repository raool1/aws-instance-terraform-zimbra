provider "aws" {
  region = var.region
  profile = "shekhar-account"
}

resource "aws_security_group" "zimbra_sg" {
  name        = "zimbra-sg"
  description = "Allow Zimbra ports"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 25
    to_port     = 7071
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

resource "aws_instance" "zimbra" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.zimbra_sg.id]
  user_data              = file("${path.module}/install_zimbra.sh")

  tags = {
    Name = "ZimbraMailServer"
  }
}

