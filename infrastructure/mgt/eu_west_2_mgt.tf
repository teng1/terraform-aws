#--------------------------------------------------------------
# Management VPC
#--------------------------------------------------------------

variable "name"               { }
variable "vpc_cidr"           { }
variable "azs"                { }
variable "region"             { }
variable "private_subnets"    { }
variable "public_subnets"     { }
variable "private_subnet_tag" { }
variable "bastion_instance_type" { }

# openvpn_vars
# variable "openvpn_instance_type" { }
# variable "openvpn_ami"           { }
# variable "openvpn_user"          { }
# variable "openvpn_admin_user"    { }
# variable "openvpn_admin_pw"      { }
# variable "openvpn_cidr"          { }
# variable "key_name"           { }
# variable "private_key"        { }
# variable "ssl_cert"           { }
# variable "route_zone_id"      { }
# variable "ssl_key"            { }
# variable "sub_domain"         { }

provider "aws" {
  region = "${var.region}"
}

module "network" {
  source = "../../modules/network"

  name            = "${var.name}"
  vpc_cidr        = "${var.vpc_cidr}"
  azs             = "${var.azs}"
  region          = "${var.region}"
  private_subnets = "${var.private_subnets}"
  public_subnets  = "${var.public_subnets}"
  private_subnet_tag = "${var.private_subnet_tag}"
  bastion_instance_type = "${var.bastion_instance_type}"
}


output "configuration" {
  value = <<CONFIGURATION
Management VPC example
CONFIGURATION
}
