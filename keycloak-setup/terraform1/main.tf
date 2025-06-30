resource "keycloak_realm" "demo" {
  realm   = "demo"
  enabled = true
}

resource "keycloak_openid_client" "demo_client" {
  realm_id                     = keycloak_realm.demo.id
  client_id                    = "demo-client"
  name                         = "Demo Client"
  access_type                  = "CONFIDENTIAL"
  valid_redirect_uris         = ["authx.provider.local:8080/*"]
  standard_flow_enabled        = true
  direct_access_grants_enabled = true
  service_accounts_enabled     = true
  client_secret                = "demo-client-secret"
}

resource "keycloak_role" "admin_role" {
  realm_id = keycloak_realm.demo.id
  name     = "admin"
}

resource "keycloak_user" "testuser" {
  realm_id = keycloak_realm.demo.id
  username = "testuser"
  email   = "testuser@demo.com"
  enabled  = true
  email_verified = true
  required_actions = []
  initial_password {
    value     = "testpassword"
    temporary = false
  }
}

resource "keycloak_user_roles" "testuser_roles" {
  realm_id = keycloak_realm.demo.id
  user_id  = keycloak_user.testuser.id
  role_ids = [keycloak_role.admin_role.id]
}
