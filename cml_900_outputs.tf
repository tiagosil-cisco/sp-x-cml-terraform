resource "local_file" "securecrt_sessions" {
  filename = "${path.module}/securecrt_sessions.xml"
  content  = <<-EOT
  <?xml version="1.0" encoding="UTF-8"?>
    <VanDyke version="3.0">
        <key name="Sessions">
            <key name="${local.project_title}">
                %{for router_name, router_config in local.xr_routers}
                <key name="${router_config.hostname}">
                    <dword name="[SSH2] Port">22</dword>
                    <string name="Hostname">${split("/", router_config.mgmt_ip)[0]}</string>
                    <string name="Username">admin</string>
                </key>
                %{endfor}
            </key>
        </key>
    </VanDyke>
  EOT
}