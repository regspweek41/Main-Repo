resource "azuread_application" "example" {
  display_name = "example"
}

resource "azuread_service_principal" "example" {
  client_id = azuread_application.example.client_id
}

resource "azuread_service_principal_password" "example" {
  service_principal_id = azuread_service_principal.example.object_id
}

resource "azuread_group" "example" {
  display_name     = "example"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true

   members = [
    data.azuread_client_config.current.object_id,
    azuread_service_principal.example.object_id,
  ]
}

