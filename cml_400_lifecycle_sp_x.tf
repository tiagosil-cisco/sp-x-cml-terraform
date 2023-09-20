

resource "cml2_lifecycle" "sp-x" {
  for_each = local.xr_routers
  lab_id   = cml2_lab.sp-x.id
  elements = [

    cml2_node.xr_routers[each.key].id
  ]
  staging = {
    stages          = ["oob_mgmt", "p", "pe", "asbr"]
    start_remaining = false
  }

  state = local.sp_x_initial_state
}

 