# leave these blank, terraform will ask you for them
variable "access_key" {}
variable "secret_key" {}

# Use North Virgina for great price and speed
variable "region" = "us-east-1"
variable "availability_zone" = "us-east-1f"

# ===================================================

# spend tier 
# setting up mulitple instances in a custom VPC and subnet
# or rolling own own 

# variable "vpc_id" = {}

# or

# data "aws_vpc" "target" {
#  id = "${var.vpc_id}"
# }

# data "aws_availability_zone" "target" {
#  name = "${var.availability_zone}"
# }

# ===================================================


#Ubuntu Server 16.04 LTS (HVM), SSD Volume Type
variable "aws_amis" = "ami-41e0b93b"


variable "key_name" {
  description = "Desired name of AWS key pair"
}