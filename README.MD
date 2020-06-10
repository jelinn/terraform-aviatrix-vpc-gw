# Aviatrix VPC GW
To simulate customer/workload VPCs/VNETs, this module creates a specified number of VPCs, instantiates Aviatrix Gateways in them and attaches those to the specified Aviatrix Transit Hub.

## Who Maintains and Approves this Module? 
Aviatrix Solution Architect Team

## Usage
```
module "aviatrix-create-avtx-vpcs-area1" {
  source         = "./create_vpcs_gws"
  cloud_type     = 1
  region         = var.aws_region
  account_name   = var.aws_account_name
  spoke_gw_size  = var.aws_spoke_gw_size
  avx_transit_gw = module.aviatrix-create-transit-aws-area1.avtx_gw_name
  vpc_count      = 2
}
```

## Inputs
```
  cloud_type     = (Required) Cloud service provider maps to AWS(1), GCP(4), AZURE(8), OCI(16), and AWSGov(256)
  region         = (Required) Cloud service provider region
  account_name   = (Required) Cloud service provider account name used on the Aviatrix Controller
  spoke_gw_size  = (Required) Cloud service provider instance size
  avx_transit_gw = (Required) Name of Aviatrix Transit Gateway
  vpc_count      = (Required) Number of spoke VPCs to be created
```
## Outputs 
None

