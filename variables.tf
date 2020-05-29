locals {
  aws   = 1
  gcp   = 4
  azure = 8
}

variable "cloud_type" {
  default = 1
}

variable "spoke_gw_size" {
  default = "t2.micro"
}
variable "vpc_count" {
  default = 2
}

variable "region" {
  default = "us-east-1"
}

variable "key_name" {
  default = "avtx-key"
}
#variable "public_key" {}
#variable "private_key" {}
variable "account_name" {}
variable "avx_transit_gw" {}
