


terraform {
  required_version = ">= 1.2.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.10.0"
    }
    azuread = {
      version = ">= 2.23.0"
    }
    kubernetes = {
      version = ">= 2.11.0"
    }
    # helm = {
    #   source  = "hashicorp/helm"
    #   version = ">= 2.5.1"
    # }
  }
}

provider "azurerm" {
  features {}
}

provider "kubernetes" {


  host                   = azurerm_kubernetes_cluster.example.kube_config.0.host
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.example.kube_config.0.cluster_ca_certificate)

  # using kubelogin to get an AAD token for the cluster.
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "kubelogin"
    args = [
      "get-token",
      "--environment",
      "AzurePublicCloud",
      "--server-id",
      data.azuread_service_principal.aks_aad_server.application_id, # Note: The AAD server app ID of AKS Managed AAD is always 6dae42f8-4368-4678-94ff-3960e28e3630 in any environments.
      "--client-id",
      azuread_application.example.application_id, # SPN App Id created via terraform
      "--client-secret",
      azuread_service_principal_password.example.value,
      "--tenant-id",
      data.azurerm_subscription.current.tenant_id, # AAD Tenant Id
      "--login",
      "spn"
    ]
  }

}


resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "example-aks1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }

azure_active_directory_role_based_access_control {
    managed                = true
    azure_rbac_enabled     = true
    admin_group_object_ids = [azuread_group.example.object_id]
    tenant_id              = data.azurerm_subscription.current.tenant_id
  }

  # azure_active_directory_role_based_access_control {
    
   
  #     client_app_id     = azuread_application.example.application_id
  #     managed           = false
  #     server_app_id     = data.azuread_service_principal.aks_aad_server.application_id
  #     server_app_secret = azuread_service_principal_password.example.value
  #     tenant_id         = data.azurerm_subscription.current.tenant_id
    
  # }

}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.example.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw

  sensitive = true
}