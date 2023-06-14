##Description : This Script is used to create VPC.
#Module      : LABEL
#Description : Terraform label module variables.
module "labels" {
  source      = "terraform-do-modules/labels/digitalocean"
  version     = "0.0.1"
  name        = var.name
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
}

#Module      : VPC
#Description : VPCs are virtual networks containing resources that can communicate with each other in full isolation, using private IP addresses.
resource "digitalocean_vpc" "default" {
  count = var.enabled == true ? 1 : 0

  name        = format("%s-vpc", module.labels.id)
  region      = var.region
  description = var.description
  ip_range    = var.ip_range
}