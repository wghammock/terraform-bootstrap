# Specify the provider and access details
# CLI will prompt user for region and keys
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}


# FREE TIER
# ===================================================

resource "aws_default_vpc" "default" {
    tags {
        Name = "Default Free VPC"
    }
}

resource "aws_subnet" "example" {
  vpc_id            = "${data.aws_vpc.selected.id}"
  availability_zone = "${var.vpc_id}"
  cidr_block        = "${cidrsubnet(data.aws_vpc.selected.cidr_block, 4, 1)}"
}

# ===================================================

# Network : Create a VPC to launch our instances into
# cost about $40 per month with no usage

# data "aws_vpc" "selected" {
#  id = "${var.vpc_id}"
# }

# Create an vpc subnet to give our subnet access to the outside world

# resource "aws_subnet" "example" {
#  vpc_id            = "${data.aws_vpc.selected.id}"
#  availability_zone = "us-west-2a"
  cidr_block        = "${cidrsubnet(data.aws_vpc.selected.cidr_block, 4, 1)}"
}

# ===================================================

resource "aws_instance" "corporate-website" {
  ami           = "${var.aws}"
  instance_type = "t2.micro"

    provisioner "local-exec" {
    command = "echo ${aws_instance.corporate-website.public_ip} > ip_address.txt"
  }
}

#Assign an elastic ip to the resource
resource "aws_eip" "ip" {
  instance = "${aws_instance.corporate-website.id}"
}

#Output to CLI when done
output "ip" {
  value = "${aws_eip.ip.public_ip}"
}