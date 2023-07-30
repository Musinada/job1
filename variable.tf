variable "ubuntu_ami_id" {
    description = "ami id of the linux machine"
    default = "ami-0f5ee92e2d63afc18"
}
variable "vpc_id" {
    description = "vpc_id under which the resource group will create"
    default = "vpc-0712f5b29ecc1e69f"
}
variable "subnet" {
    description = "subnet id of the vpc"
    default = "subnet-0843de099cd275280"
}
variable "cidr_blocks" {
    description = "subnet ip range in cidr block"
    default = ["0.0.0.0/0"]
}

variable "region" {
    description = "aws region"
    default = "ap-south-1"
}
variable "volume_type" {
    description = "type of the storage"
    default = "gp2"
}