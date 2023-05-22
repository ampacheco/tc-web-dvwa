# Define Azure provider configuration
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "dvwa-aci-RG"
  location = "East US"
}

resource "azurerm_container_group" "example" {
  name                = "example-continst"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  ip_address_type     = "Public"
  dns_name_label      = "aci-label"
  os_type             = "Linux"

  container {
    name   = "dvwa-on-aci"
    image  = "vulnerables/web-dvwa:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  tags = {
    environment = "vulnerables-dvwa"
  }
}
