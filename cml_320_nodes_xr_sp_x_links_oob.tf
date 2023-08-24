// Links from all XR routers MGMT interface to the OOB unmanaged switch
resource "cml2_link" "xr_oob_links" {
  for_each = var.xr_routers
  lab_id   = cml2_lab.sp-x.id
  node_a   = cml2_node.xr_routers[each.key].id
  node_b   = cml2_node.L2_SW_EXT_CON.id
  slot_a   = 0

}
