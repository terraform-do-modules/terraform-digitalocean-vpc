# Terraform / OpenTofu version
terraform {
  required_version = ">= 1.10.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.70.0"
    }
  }

  provider_meta "digitalocean" {
    module_name = "terraform-do-modules/terraform-digitalocean-vpc"
  }
}
