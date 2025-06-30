
resource "keycloak_openid_client" "authx_client" {
  realm_id                     = var.realm_id
  client_id                    = "authx-client"
  name                         = "Demo Client"
  access_type                  = "CONFIDENTIAL"
  valid_redirect_uris         = ["authx.provider.local:8080/*"]
  standard_flow_enabled        = true
  direct_access_grants_enabled = true
  service_accounts_enabled     = true
  client_secret                = "authx-client-secret"
}
