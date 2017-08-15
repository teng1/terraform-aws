#--------------------------------------------------------------
# Network
#--------------------------------------------------------------
name               = "mgt"
region             = "eu-west-2"
vpc_cidr           = "10.11.0.0/16"

# subnets are interpolated alternately by the private_subnets module,
# az-a, az-b, az-a, az-b, az-a etc
azs                = "eu-west-2a,eu-west-2b"
private_subnets    = "10.11.0.0/19,10.11.64.0/19,10.11.48.0/21,10.11.112.0/21,10.11.56.0/21,10.11.120.0/21"
public_subnets     = "10.11.32.0/20,10.11.96.0/20"
private_subnet_tag = "lan-01,lan-01,lan-02,lan-02,lan-03,lan-03"






#
# azs             = {
#   "a" = "eu-west-2a"
#   "b" = "eu-west-2b"
#   }
#
# private_subnets = {
#   "eu-west-2a" = "10.11.0.0/19,10.11.48.0/21,10.11.56.0/21"
#   "eu-west-2b" = "10.11.64.0/19,10.11.112.0/21,10.11.120.0/21"
#   }
# public_subnets = {
#   "eu-west-2a" = "10.11.32.0/20"
#   "eu-west-2b" = "10.11.96.0/20"
# }
