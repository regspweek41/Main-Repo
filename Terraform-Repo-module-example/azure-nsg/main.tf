resource "azurerm_resource_group" "example" {
  name     = "example-resources25"
  location = "West Europe"
}

provider "azurerm" {
  features {}
    subscription_id = "491e1121-c626-46e3-98ba-98f9f0434964"
    tenant_id = "2047b1bd-994d-4366-9d87-647dac583343"
    client_id = "a78d2362-7c1d-475b-b06c-683634019705"
    client_secret = "aSR8Q~UzW_2fWfpMnAHLnY~04qdEl~tjRbS0XbUB"
  
}

resource "azurerm_network_security_group" "example" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  dynamic "security_rule" {
    for_each = var.security-rules
    content {

    name                       = security_rule.value.name
    priority                   = security_rule.value.priority
    direction                  = security_rule.value.direction
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
      
    }

  }

  tags = {
    environment = "Production"
  }
}