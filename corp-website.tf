# Usage
# terraform plan -var-file=terraform.tfvars -var-file=variables.tf
# terraform apply -var-file=terraform.tfvars -var-file=variables.tf

# Specify the provider and access details
provider "aws" {
	region 						= "${var.region}"
	shared_credentials_file 	= "${var.shared_creds}"
}


# FREE TIER
# ===================================================

# make and download this file pre-hand place in tfvars file
keypair_name = "${var.sshkey}"

resource "aws_default_vpc" "default" {
	tags {
		Name = "Default Free VPC"
	}
}

# Retrieve the AZ where we want to create network resources
data "aws_availability_zone" "corporate-website" {
	name = "${var.az}"
}

# ===================================================

resource "aws_instance" "corporate-website" {
	ami 			= "${var.aws_ami}"
	instance_type 	= "t2.micro"

	provisioner "local-exec" {
		command 	= "echo ${aws_instance.corporate-website.public_ip} > ip_address.txt"
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
