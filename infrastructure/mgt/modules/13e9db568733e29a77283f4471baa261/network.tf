#--------------------------------------------------------------
# Network module
#--------------------------------------------------------------

variable "name"               { }
variable "vpc_cidr"           { }
variable "azs"                { }
variable "region"             { }
variable "private_subnets"    { }
variable "public_subnets"     { }
variable "private_subnet_tag" { }
# variable "route_zone_id"   { }

module "vpc" {
  source = "./vpc"

  name = "${var.name}-vpc"
  cidr = "${var.vpc_cidr}"
}

module "public_subnets" {
  source = "./public_subnet"

  name   = "${var.name}-public"
  vpc_id = "${module.vpc.vpc_id}"
  cidrs  = "${var.public_subnets}"
  azs    = "${var.azs}"
}

module "nat" {
  source = "./nat"

  name              = "${var.name}-nat"
  azs               = "${var.azs}"
  public_subnet_ids = "${module.public_subnets.subnet_ids}"
}

module "private_subnets" {
  source = "./private_subnet"

  name   = "${var.name}-private"
  vpc_id = "${module.vpc.vpc_id}"
  cidrs  = "${var.private_subnets}"
  azs    = "${var.azs}"
  nat_gateway_ids = "${module.nat.nat_gateway_ids}"
  private_subnet_tag = "${var.private_subnet_tag}"
}


# VPC
output "vpc_id"   { value = "${module.vpc.vpc_id}" }
output "vpc_cidr" { value = "${module.vpc.vpc_cidr}" }
output "public_subnet_ids"  { value = "${module.public_subnets.subnet_ids}" }
output "private_subnet_ids" { value = "${module.private_subnets.subnet_ids}" }
output "nat_gateway_ids" { value = "${module.nat.nat_gateway_ids}" }
