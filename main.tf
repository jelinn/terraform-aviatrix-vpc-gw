resource "random_integer" "subnet" {
  min = 1
  max = 250
}

data "aws_availability_zones" "az_available" {}

resource "aviatrix_vpc" "aws_vpc_w_gw" {
  count                = var.vpc_count
  cloud_type           = var.cloud_type
  account_name         = var.account_name
  region               = var.region
  name                 = "lab-avtx-${count.index + 1}${var.cloud_type}"
  cidr                 = cidrsubnet("10.0.0.0/8", 8, random_integer.subnet.result + count.index)
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
}

resource "aviatrix_spoke_gateway" "avtx_spoke_vpc" {
  count              = var.vpc_count
  cloud_type         = var.cloud_type
  account_name       = var.account_name
  gw_name            = "spoke-gw${count.index+1}${var.cloud_type}"
  vpc_id             = aviatrix_vpc.aws_vpc_w_gw[count.index].vpc_id
  vpc_reg            = var.region
  gw_size            = var.spoke_gw_size
  subnet             = var.cloud_type == 1 ? aviatrix_vpc.aws_vpc_w_gw[count.index].subnets[length(data.aws_availability_zones.az_available.names)]["cidr"] : aviatrix_vpc.aws_vpc_w_gw[count.index].subnets[0]["cidr"]
  ha_subnet          = var.cloud_type == 1 ? aviatrix_vpc.aws_vpc_w_gw[count.index].subnets[length(data.aws_availability_zones.az_available.names) + 1]["cidr"] : aviatrix_vpc.aws_vpc_w_gw[count.index].subnets[1]["cidr"]
  ha_gw_size         = var.spoke_gw_size
  transit_gw         = var.avx_transit_gw
  enable_active_mesh = true
}
