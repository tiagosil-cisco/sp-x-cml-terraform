locals {
  project_title        = "SP-RBC-TF"
  project_description  = "Topology created using Terraform to represent SP-X"
  ext_conn_bridge_info = "bridge1"         // Make sure to create proper bridge first via Cockpit
  sp_x_initial_state   = "DEFINED_ON_CORE" // Options are DEFINED_ON_CORE, STOPPED, STARTED, BOOTED
  default_xr_username  = "admin"
  default_xr_password  = "C!sco123"
  day0_xr_cfg          = "day0-xr.tftpl"
  day0_xe_cfg          = "day0-xe.tftpl"
  xr_routers           = jsondecode(file("${path.module}/sp-x-cml-terraform-vars.json"))
  mgmt_cidr            = "10.0.1.0/24"
  mgmt_cidr_offset     = "100"
}

variable "cml_address" {
  type = string
  sensitive = false
}
variable "cml_username" {
  type = string
  sensitive = false
}

variable "cml_password" {
  type = string
  sensitive = false
}

// ALl point to point links that will be created between XR routers. Note that Gig0/0/0/0 is 3 and it increases from there.
variable "links" {
  type = map(any)
  default = {
    pe1_pe2 = {
      node_a = "pe1"
      node_b = "pe2"
      slot_a = 13
      slot_b = 13
    },
    pe1_p1 = {
      node_a = "pe1"
      node_b = "p1"
      slot_a = 3
      slot_b = 3
    },
    pe1_p2 = {
      node_a = "pe1"
      node_b = "p2"
      slot_a = 4
      slot_b = 3
    },
    pe2_p1 = {
      node_a = "pe2"
      node_b = "p1"
      slot_a = 3
      slot_b = 4
    },
    pe2_p2 = {
      node_a = "pe2"
      node_b = "p2"
      slot_a = 4
      slot_b = 4
    },
    pe3_pe4 = {
      node_a = "pe3"
      node_b = "pe4"
      slot_a = 13
      slot_b = 13
    },
    pe3_p3 = {
      node_a = "pe3"
      node_b = "p3"
      slot_a = 3
      slot_b = 3
    },
    pe3_p4 = {
      node_a = "pe3"
      node_b = "p4"
      slot_a = 4
      slot_b = 3
    },
    pe4_p3 = {
      node_a = "pe4"
      node_b = "p3"
      slot_a = 3
      slot_b = 4
    },
    pe4_p4 = {
      node_a = "pe4"
      node_b = "p4"
      slot_a = 4
      slot_b = 4
    },
    p1_p2 = {
      node_a = "p1"
      node_b = "p2"
      slot_a = 13
      slot_b = 13
    },
    p3_p4 = {
      node_a = "p3"
      node_b = "p4"
      slot_a = 13
      slot_b = 13
    },
    p1_p3 = {
      node_a = "p1"
      node_b = "p3"
      slot_a = 5
      slot_b = 5
    },
    p1_p4 = {
      node_a = "p1"
      node_b = "p4"
      slot_a = 6
      slot_b = 5
    },
    p2_p3 = {
      node_a = "p2"
      node_b = "p3"
      slot_a = 5
      slot_b = 6
    },
    p2_p4 = {
      node_a = "p2"
      node_b = "p4"
      slot_a = 6
      slot_b = 6
    },
    asbr1_asbr2 = {
      node_a = "asbr1"
      node_b = "asbr2"
      slot_a = 13
      slot_b = 13
    },
    p2_asbr1 = {
      node_a = "p2"
      node_b = "asbr1"
      slot_a = 7
      slot_b = 3
    },
    p2_asbr2 = {
      node_a = "p2"
      node_b = "asbr2"
      slot_a = 8
      slot_b = 3
    },
    p4_asbr1 = {
      node_a = "p4"
      node_b = "asbr1"
      slot_a = 7
      slot_b = 4
    },
    p4_asbr2 = {
      node_a = "p4"
      node_b = "asbr2"
      slot_a = 8
      slot_b = 4
    },
    p1_rrpce1 = {
      node_a = "p1"
      node_b = "rrpce1"
      slot_a = 7
      slot_b = 3
    },
    p3_rrpce2 = {
      node_a = "p3"
      node_b = "rrpce2"
      slot_a = 7
      slot_b = 3
    },
    ce1_pe1 = {
      node_a = "ce1"
      node_b = "pe1"
      slot_a = "1"
      slot_b = "5"
    }
    ce1_pe2 = {
      node_a = "ce1"
      node_b = "pe2"
      slot_a = "2"
      slot_b = "5"
    },
    ce2_pe3 = {
      node_a = "ce2"
      node_b = "pe3"
      slot_a = "1"
      slot_b = "5"
    }
    ce2_pe4 = {
      node_a = "ce2"
      node_b = "pe4"
      slot_a = "2"
      slot_b = "5"
    }
  }
}