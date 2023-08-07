// Providers

provider "aws" {
  region = var.location
}


// Client Server - EC2 machine

resource "aws_instance" "demo-server" {
 ami = var.os_name
 key_name = var.key 
 instance_type  = var.instance-type
 associate_public_ip_address = true
 subnet_id = aws_subnet.demo_subnet-1.id
 vpc_security_group_ids = [aws_security_group.demo-vpc-sg.id]
}


// Create VPC
resource "aws_vpc" "demo-vpc" {
  cidr_block = var.vpc-cidr
}


// Create Subnet

resource "aws_subnet" "demo_subnet-1" {
  vpc_id     = aws_vpc.demo-vpc.id 
  cidr_block = var.subnet1-cidr
  availability_zone = var.subnet_az
  map_public_ip_on_launch = "true"

  tags = {
    Name = "demo_subnet-1"
  }
}

resource "aws_subnet" "demo_subnet-2" {
  vpc_id     = aws_vpc.demo-vpc.id 
  cidr_block = var.subnet2-cidr
  availability_zone = var.subnet_az-2
  map_public_ip_on_launch = "true"

  tags = {
    Name = "demo_subnet-2"
  }
}


// Create Internet Gateway

resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "demo-igw"
  }
}


// Routetable

resource "aws_route_table" "demo-rt" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-igw.id
  }
  tags = {
    Name = "demo-rt"
  }
}


// associate subnet1 with route table 

resource "aws_route_table_association" "demo-rt_association-1" {
  subnet_id      = aws_subnet.demo_subnet-1.id 
  route_table_id = aws_route_table.demo-rt.id
}

// associate subnet2 with route table
resource "aws_route_table_association" "demo-rt_association-2" {
  subnet_id      = aws_subnet.demo_subnet-2.id 
  route_table_id = aws_route_table.demo-rt.id
}


//Create a Security Group 

resource "aws_security_group" "demo-vpc-sg" {
  name        = "demo-vpc-sg"
 
  vpc_id      = aws_vpc.demo-vpc.id

  ingress {

    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}


// Modules for EKS cluster and Security Group

module "sgs" {
  source = "./SG_EKS"
  vpc_id = aws_vpc.demo-vpc.id

}

module "eks" {
  source = "./EKS"
  sg_ids = module.sgs.security_group_public
  vpc_id = aws_vpc.demo-vpc.id
  subnet_ids = [aws_subnet.demo_subnet-1.id,aws_subnet.demo_subnet-2.id]

}
