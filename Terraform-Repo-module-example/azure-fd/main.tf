resource "azurerm_resource_group" "example" {
  name     = "FrontDoorExampleResourceGroup23"
  location = "West Europe"
}

provider "azurerm" {
  features {}
  subscription_id = "491e1121-c626-46e3-98ba-98f9f0434964"
  tenant_id       = "2047b1bd-994d-4366-9d87-647dac583343"
  client_id       = "a78d2362-7c1d-475b-b06c-683634019705"
  client_secret   = "aSR8Q~UzW_2fWfpMnAHLnY~04qdEl~tjRbS0XbUB"

}

resource "azurerm_frontdoor" "example" {
  name                = "example-FrontDoor243"
  resource_group_name = azurerm_resource_group.example.name

  dynamic "routing_rule" {
    for_each = var.routing-rule
    content {
      name               = routing_rule.value.name
      accepted_protocols = routing_rule.value.accepted_protocols
      patterns_to_match  = routing_rule.value.patterns_to_match
      frontend_endpoints = routing_rule.value.frontend_endpoints

      dynamic "forwarding_configuration" {
        for_each = routing_rule.value.configuration == "forward" ? [routing_rule.value.forwarding_configuration] : []

        content {

          forwarding_protocol = routing_rule.value.forwarding_configuration.forwarding_protocol
          backend_pool_name   = routing_rule.value.forwarding_configuration.backend_pool_name
        }

      }

    }

  }



 




  backend_pool_load_balancing {
    name = "exampleLoadBalancingSettings1"
  }

  backend_pool_health_probe {
    name = "exampleHealthProbeSetting1"
  }

  backend_pool {
    name = "exampleBackendBing"
    backend {
      host_header = "www.bing.com"
      address     = "www.bing.com"
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "exampleLoadBalancingSettings1"
    health_probe_name   = "exampleHealthProbeSetting1"
  }

  frontend_endpoint {
    name      = "exampleFrontendEndpoint1"
    host_name = "example-FrontDoor243.azurefd.net"
  }
}
