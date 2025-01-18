terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
    }
    }
}

provider "aws" {
    region = "eu-north-1"
}

#This block is responsible for creation of EC2 Instance
resource "aws_instance" "web-server-instance" {
    ami = "ami-067f484fdbe6dd509" #Predefined AMI with instaled Apache that shows 'Well Done' message when connecting
    instance_type = "t2.micro"
    key_name = "SpaceliftKeyPair"
    vpc_security_group_ids = [aws_security_group.httpconnection.id] #Connecting the instance to the internet

tags = {
    Name = "spacelift-course-server"
}
}

#This code allows us to connect the EC2 to the internet. Details of this block are not important right now.
resource "aws_security_group" "httpconnection" {
  description = "Allow incoming HTTP traffic on port 80"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}