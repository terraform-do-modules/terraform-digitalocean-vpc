##------------------------------------------------
## Provider configuration
## Set DIGITALOCEAN_TOKEN env var or use token argument
##------------------------------------------------
provider "digitalocean" {}

##------------------------------------------------
## VPC module call
##
## Deploy with Terraform:
##   terraform init && terraform apply
##
## Deploy with OpenTofu:
##   tofu init && tofu apply
##------------------------------------------------
module "vpc" {
  source      = "./../../"
  name        = "app"
  environment = "test"
  region      = "blr1"
  ip_range    = "10.10.0.0/16"
  description = "VPC for application workloads"
  label_order = ["name", "environment"]
}
