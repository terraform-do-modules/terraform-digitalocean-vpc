# Terraform / OpenTofu version
terraform {
  required_version = ">= 2.70.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.70.0"
    }
  }
}