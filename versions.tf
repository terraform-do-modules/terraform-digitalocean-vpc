# Terraform version
terraform {
  required_version = ">= 0.15"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}
