
module "realm" {
  source = "./modules/realm"
  providers = {
    keycloak = keycloak
  }
}

module "client" {
  source = "./modules/client"
  providers = {
    keycloak = keycloak
  }
  realm_id = module.realm.id
}

module "user" {
  source = "./modules/user"
  providers = {
    keycloak = keycloak
  }
  realm_id = module.realm.id
}
