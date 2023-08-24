// Point-to-point links between XR routers
resource "cml2_link" "xr_p2p_links" {
  for_each = var.links
  lab_id   = cml2_lab.sp-x.id
  node_a   = cml2_node.xr_routers[each.value.node_a].id
  node_b   = cml2_node.xr_routers[each.value.node_b].id
  slot_a   = each.value.slot_a
  slot_b   = each.value.slot_b
}