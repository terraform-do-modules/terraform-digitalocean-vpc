
provider "digitalocean" {
  # You need to set this in your .bashrc
  # export DIGITALOCEAN_TOKEN="Your API TOKEN"
  token = ""
}

module "vpc" {
  source      = "./../"
  name        = "app"
  environment = "test"
  region      = "bangalore-1"
  ip_range    = "10.0.0.0/16"
}
