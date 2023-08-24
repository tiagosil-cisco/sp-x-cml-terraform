locals {
  project_title        = "SP-X"
  project_description  = "Topology created using Terraform to represent SP-X"
  ext_conn_bridge_info = "bridge1" // Make sure to create proper bridge first via Cockpit
  xrv_node_definition  = "iosxrv9000" // Adapt this node ID based on the XR router definition available in your CML Instance
  sp_x_initial_state   = "DEFINED_ON_CORE" // Options are DEFINED_ON_CORE, STOPPED, STARTED, BOOTED

}

//Information to connect to your CML instance. 
variable "cml_info" {
  type = map(string)
  default = {
    username = "bridge"
    password = "C!sco123"
    url      = "https://10.0.10.67"
  }
  sensitive = false
}

// All the XR routers that will be running on this topology and theirs information
variable "xr_routers" {
  type = map(any)
  default = {
    pe1 = {
      hostname       = "SP-X-XRv-PE01"
      tags           = ["pe"]
      x              = 0
      y              = 0
      mgmt_interface = "MgmtEth0/RP0/CPU0/0"
      mgmt_vrf       = "MGMT"
      mgmt_ip        = "10.0.1.51/24"
      mgmt_gw        = "10.0.1.1"
    },
    pe2 = {
      hostname       = "SP-X-XRv-PE02"
      tags           = ["pe"]
      x              = 0
      y              = 200
      mgmt_interface = "MgmtEth0/RP0/CPU0/0"
      mgmt_vrf       = "MGMT"
      mgmt_ip        = "10.0.1.52/24"
      mgmt_gw        = "10.0.1.1"
    },
    p1 = {
      hostname       = "SP-X-XRv-P01"
      tags           = ["p"]
      x              = 200
      y              = 0
      mgmt_interface = "MgmtEth0/RP0/CPU0/0"
      mgmt_vrf       = "MGMT"
      mgmt_ip        = "10.0.1.53/24"
      mgmt_gw        = "10.0.1.1"
    },
    p2 = {
      hostname       = "SP-X-XRv-P02"
      tags           = ["p"]
      x              = 200
      y              = 200
      mgmt_interface = "MgmtEth0/RP0/CPU0/0"
      mgmt_vrf       = "MGMT"
      mgmt_ip        = "10.0.1.54/24"
      mgmt_gw        = "10.0.1.1"
    },
    p3 = {
      hostname       = "SP-X-XRv-P03"
      tags           = ["p"]
      x              = 400
      y              = 0
      mgmt_interface = "MgmtEth0/RP0/CPU0/0"
      mgmt_vrf       = "MGMT"
      mgmt_ip        = "10.0.1.55/24"
      mgmt_gw        = "10.0.1.1"
    },
    p4 = {
      hostname       = "SP-X-XRv-P04"
      tags           = ["p"]
      x              = 400
      y              = 200
      mgmt_interface = "MgmtEth0/RP0/CPU0/0"
      mgmt_vrf       = "MGMT"
      mgmt_ip        = "10.0.1.56/24"
      mgmt_gw        = "10.0.1.1"
    },
    pe3 = {
      hostname       = "SP-X-XRv-PE03"
      tags           = ["pe"]
      x              = 600
      y              = 0
      mgmt_interface = "MgmtEth0/RP0/CPU0/0"
      mgmt_vrf       = "MGMT"
      mgmt_ip        = "10.0.1.57/24"
      mgmt_gw        = "10.0.1.1"
    },
    pe4 = {
      hostname       = "SP-X-XRv-PE04"
      tags           = ["pe"]
      x              = 600
      y              = 200
      mgmt_interface = "MgmtEth0/RP0/CPU0/0"
      mgmt_vrf       = "MGMT"
      mgmt_ip        = "10.0.1.58/24"
      mgmt_gw        = "10.0.1.1"
    },
    asbr1 = {
      hostname       = "SP-X-XRv-ASBR01"
      tags           = ["asbr"]
      x              = 200
      y              = 400
      mgmt_interface = "MgmtEth0/RP0/CPU0/0"
      mgmt_vrf       = "MGMT"
      mgmt_ip        = "10.0.1.59/24"
      mgmt_gw        = "10.0.1.1"
    },
    asbr2 = {
      hostname       = "SP-X-XRv-ASBR02"
      tags           = ["asbr"]
      x              = 400
      y              = 400
      mgmt_interface = "MgmtEth0/RP0/CPU0/0"
      mgmt_vrf       = "MGMT"
      mgmt_ip        = "10.0.1.60/24"
      mgmt_gw        = "10.0.1.1"
    },
    rrpce1 = {
      hostname       = "SP-X-XRv-RRPCE01"
      tags           = ["rrpce"]
      x              = 200
      y              = -200
      mgmt_interface = "MgmtEth0/RP0/CPU0/0"
      mgmt_vrf       = "MGMT"
      mgmt_ip        = "10.0.1.61/24"
      mgmt_gw        = "10.0.1.1"
    },
    rrpce2 = {
      hostname       = "SP-X-XRv-RRPCE02"
      tags           = ["rrpce"]
      x              = 400
      y              = -200
      mgmt_interface = "MgmtEth0/RP0/CPU0/0"
      mgmt_vrf       = "MGMT"
      mgmt_ip        = "10.0.1.62/24"
      mgmt_gw        = "10.0.1.1"
    },
  }
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

  }
}