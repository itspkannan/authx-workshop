resource "keycloak_realm" "demo" {
  realm   = "demo"
  enabled = true
}


output "id" {
  value = keycloak_realm.demo.id
}