//Unmanaged Switch
resource "cml2_node" "L2_SW_EXT_CON" {
  lab_id         = cml2_lab.sp-x.id
  label          = "L2_SW_EXT_CON"
  nodedefinition = "unmanaged_switch"
  tags           = ["oob_mgmt"]
  x              = 300
  y              = -400
}

//External Conn
resource "cml2_node" "EXT_CON" {
  lab_id         = cml2_lab.sp-x.id
  label          = "SW_EXT_CON"
  nodedefinition = "external_connector"
  tags           = ["oob_mgmt"]
  x              = 300
  y              = -600
  configuration  = local.ext_conn_bridge_info
}