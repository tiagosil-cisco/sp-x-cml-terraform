
// all XR router have a similar startup config to allow remote management.
resource "cml2_node" "xr_routers" {
  for_each       = local.xr_routers
  //for_each =  {for key, val in local.xr_routers: 
  //             key => val if val.node_definition == "iosxrv9000"}
  lab_id         = cml2_lab.sp-x.id
  label          = each.value.hostname
  nodedefinition = each.value.node_definition
  tags           = each.value.tags
  x              = each.value.x
  y              = each.value.y

  configuration = templatefile(each.value.node_definition=="iosxrv9000" ? local.day0_xr_cfg : local.day0_xe_cfg,{
      hostname = each.value.hostname,
      default_xr_username = local.default_xr_username,
      default_xr_password = local.default_xr_password,
      mgmt_vrf = each.value.mgmt_vrf,
      mgmt_interface = each.value.mgmt_interface,
      mgmt_ip = each.value.mgmt_ip,
      # mgmt_ip = cidrhost(local.mgmt_cidr, 
      #                   local.mgmt_cidr_offset + index([for key, val in local.xr_routers: val.hostname], each.value.hostname))
      mgmt_gw = each.value.mgmt_gw
      }
    )
}

