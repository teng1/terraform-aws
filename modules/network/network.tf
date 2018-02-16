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

variable "bastion_instance_type" { }

# openvpn vars
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

module "bastion" {
  source = "./bastion"

  name              = "${var.name}-bastion"
  vpc_id            = "${module.vpc.vpc_id}"
  vpc_cidr          = "${module.vpc.vpc_cidr}"
  region            = "${var.region}"
  public_subnet_ids = "${module.public_subnets.subnet_ids}"
  # key_name          = "${var.key_name}"
  instance_type     = "${var.bastion_instance_type}"
}

# module "openvpn" {
#   source = "./openvpn"
#
#   name               = "${var.name}-openvpn"
#   vpc_id             = "${module.vpc.vpc_id}"
#   vpc_cidr           = "${module.vpc.vpc_cidr}"
#   public_subnet_ids  = "${module.public_subnets.subnet_ids}"
#   ssl_cert           = "${var.ssl_cert}"
#   ssl_key            = "${var.ssl_key}"
#   key_name           = "${var.key_name}"
#   private_key        = "${var.private_key}"
#   ami                = "${var.openvpn_ami}"
#   instance_type      = "${var.openvpn_instance_type}"
#   bastion_host       = "${module.bastion.public_ip}"
#   bastion_user       = "${module.bastion.user}"
#   openvpn_user       = "${var.openvpn_user}"
#   openvpn_admin_user = "${var.openvpn_admin_user}"
#   openvpn_admin_pw   = "${var.openvpn_admin_pw}"
#   vpn_cidr           = "${var.openvpn_cidr}"
#   sub_domain         = "${var.sub_domain}"
#   route_zone_id      = "${var.route_zone_id}"
# }

# VPC
output "vpc_id"   { value = "${module.vpc.vpc_id}" }
output "vpc_cidr" { value = "${module.vpc.vpc_cidr}" }
output "public_subnet_ids"  { value = "${module.public_subnets.subnet_ids}" }
output "private_subnet_ids" { value = "${module.private_subnets.subnet_ids}" }

# NAT
output "nat_gateway_ids" { value = "${module.nat.nat_gateway_ids}" }

# Bastion
output "bastion_user"       { value = "${module.bastion.user}" }
output "bastion_private_ip" { value = "${module.bastion.private_ip}" }
output "bastion_public_ip"  { value = "${module.bastion.public_ip}" }
