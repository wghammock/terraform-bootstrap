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

# Retrieve the AZ where we want to create network resources
data "aws_availability_zone" "corporate-website" {
  name = "${var.availability_zone}"
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
