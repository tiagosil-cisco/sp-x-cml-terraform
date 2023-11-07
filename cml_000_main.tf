terraform {
  required_providers {
    cml2 = {
      source = "registry.terraform.io/ciscodevnet/cml2"
    }
  }
}

provider "cml2" {
  address = "${var.cml_address}"
  username = "${var.cml_username}"
  password = "${var.cml_password}"
  skip_verify = true
}