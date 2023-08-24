terraform {
  required_providers {
    cml2 = {
      source = "registry.terraform.io/ciscodevnet/cml2"
    }
  }
}

provider "cml2" {

  address     = var.cml_info.url
  username    = var.cml_info.username
  password    = var.cml_info.password
  skip_verify = true
}