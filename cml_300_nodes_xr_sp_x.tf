
// all XR router have a similar startup config to allow remote management.
resource "cml2_node" "xr_routers" {
  for_each       = local.xr_routers
  lab_id         = cml2_lab.sp-x.id
  label          = each.value.hostname
  nodedefinition = local.xrv_node_definition
  tags           = each.value.tags
  x              = each.value.x
  y              = each.value.y
  configuration  = <<-EOT
    hostname ${each.value.hostname}
    username ${local.default_xr_username}
    group root-lr
    group cisco-support
    password ${local.default_xr_password}
    exit
    tpa
    vrf ${each.value.mgmt_vrf}
    address-family ipv4
    update-source dataports ${each.value.mgmt_interface}
    root
    vrf ${each.value.mgmt_vrf}
    address-family ipv4 unicast
    exit
    exit
    grpc vrf ${each.value.mgmt_vrf}
    interface ${each.value.mgmt_interface}
    vrf ${each.value.mgmt_vrf} 
    ipv4 address ${each.value.mgmt_ip}
    no shutdown
    exit
    router static vrf ${each.value.mgmt_vrf} address-family ipv4 unicast
    0.0.0.0/0 ${each.value.mgmt_gw}
    root
    telnet vrf ${each.value.mgmt_vrf} ipv4 server max-servers 100
    telnet vrf ${each.value.mgmt_vrf} ipv6 server max-servers 100
    ssh server logging
    ssh server rate-limit 100
    ssh server session-limit 100
    ssh server v2
    ssh server vrf ${each.value.mgmt_vrf}
    ssh server netconf vrf ${each.value.mgmt_vrf}
    end
    EOT 
}

