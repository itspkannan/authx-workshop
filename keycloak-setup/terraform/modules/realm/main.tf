resource "keycloak_realm" "authx" {
  realm   = "authx"
  enabled = true
}


output "id" {
  value = keycloak_realm.authx.id
}