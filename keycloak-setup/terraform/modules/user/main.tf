
resource "keycloak_role" "admin_role" {
  realm_id = var.realm_id
  name     = "admin"
}

resource "keycloak_user" "testuser" {
  realm_id = var.realm_id
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
  realm_id = var.realm_id
  user_id  = keycloak_user.testuser.id
  role_ids = [keycloak_role.admin_role.id]
}