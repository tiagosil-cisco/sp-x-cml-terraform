resource "local_file" "securecrt_sessions" {

  filename = "${path.module}/securecrt_sessions.xml"
  content  = <<-EOT
  <?xml version="1.0" encoding="UTF-8"?>
    <VanDyke version="3.0">
        <key name="Sessions">
            <key name="${local.project_title}">
                %{ for i, hostname in var.xr_routers }
                <key name="${var.xr_routers[i].hostname}">
                    <dword name="[SSH2] Port">22</dword>
                    <string name="Hostname">${var.xr_routers[i].mgmt_ip}</string>
                    <string name="Username">admin</string>
                </key>
                %{ endfor }
            </key>
        </key>
    </VanDyke>
  EOT
}