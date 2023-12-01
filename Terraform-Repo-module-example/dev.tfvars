subnetname             = "add_subnet"
rgname                 = "8pmbatch-RG"
nertworkname           = "8pmbatch-vent"
address                = ["10.5.3.0/24"]
dbname                 = "postgres-4578"
location               = "UK South"
administrator_login    = "zpadmin"
administrator_password = "Je32WERTE!!"
zone                   = "1"
storage_mb             = "32768"
sku_name               = "GP_Standard_D4s_v3"
dnsname                = "exmples1.postgres.database.azure.com"
security-rules = [
{
    name = "rule1"
    priority = 100
    direction = "Inbound"
},
{
    name = "rule2"
    priority = 101
    direction = "Inbound"
},
{
     name = "rule3"
    priority = 102
    direction = "Inbound"
}]

routing-rule = {
    rule1 = {
    name               = "exampleRoutingRule1"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["exampleFrontendEndpoint1"]
    configuration      = "forward"
    forwarding_configuration = {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "exampleBackendBing"
    }

    }
    rule2 = {
    name               = "exampleRoutingRule1"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["exampleFrontendEndpoint1"]
    configuration      = "forward"
    forwarding_configuration = {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "exampleBackendBing"
    }

    }
