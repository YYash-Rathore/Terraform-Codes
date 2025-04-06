resource "aws_key_pair" my_key { 
    key_name = "terra-key-ec2"
    public_key = file("terra-key-ec2.pub")
}

resource "aws_default_vpc" "default" {
  
}

resource "aws_security_group" "my_security_group" {
  name        = "automate-sg"
  description = "This security group is created using Terraform"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Created by Terraform" 
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Created by Terraform"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Created by Terraform"
  }

  tags = {
    Name = "automate-sg"
  }
}

resource aws_instance my_instance {
    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my_security_group.name]
    instance_type = var.ec2_instance_type
    ami = var.ec2_ami_id
    user_data = file("install_nginx.sh")
    root_block_device {
        volume_size = var.ec2_root_volume_size
        volume_type = "gp3"
        delete_on_termination = true
    }
    tags = {
        Name = "Automate-ec2"
    }
}