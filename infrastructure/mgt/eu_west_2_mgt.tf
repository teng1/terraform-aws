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
  # route_zone_id   = "${terraform_remote_state.aws_global.output.zone_id}"
}


output "configuration" {
  value = <<CONFIGURATION
Management VPC example
CONFIGURATION
}
