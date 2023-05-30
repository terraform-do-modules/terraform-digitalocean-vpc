
provider "digitalocean" {
  # You need to set this in your .bashrc
  # export DIGITALOCEAN_TOKEN="Your API TOKEN"
  token = "dop_v1_677763b63d63a9cba824df50b797d03a080e1987de4c014682df19c080fd1dad"
}

module "vpc" {
  source      = "./../"
  name        = "app"
  environment = "test"
  region      = "bangalore-1"
  ip_range    = "10.0.0.0/16"
}
