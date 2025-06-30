output "authx_client_id" {
  value = keycloak_openid_client.authx_client.client_id
}

output "authx_client_secret" {
  value     = keycloak_openid_client.authx_client.client_secret
  sensitive = true
}