#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. `name`."
}

#Module      : VPC
#Description : VPCs are virtual networks containing resources that can communicate with each other in full isolation, using private IP addresses.
variable "enabled" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable vpc."
}

variable "region" {
  type        = string
  default     = "blr1"
  description = "The region to create VPC, like ``london-1`` , ``bangalore-1`` ,``newyork-3`` ``toronto-1``. "
}

variable "description" {
  type        = string
  default     = "VPC"
  description = "A free-form text field up to a limit of 255 characters to describe the VPC."
}

variable "ip_range" {
  type        = string
  default     = ""
  description = "The range of IP addresses for the VPC in CIDR notation. Network ranges cannot overlap with other networks in the same account and must be in range of private addresses as defined in RFC1918. It may not be larger than /16 or smaller than /24."
}

variable "managedby" {
  type        = string
  default     = "terraform-do-modules"
  description = "ManagedBy, eg 'terraform-do-modules' or 'hello@clouddrove.com'"
}