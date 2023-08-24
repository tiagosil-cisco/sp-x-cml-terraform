
//Links between ExtConn and unmanaged switch
resource "cml2_link" "oob_mgmt_link" {
  lab_id = cml2_lab.sp-x.id
  node_a = cml2_node.L2_SW_EXT_CON.id
  node_b = cml2_node.EXT_CON.id
  slot_a = 31
  slot_b = 0
}