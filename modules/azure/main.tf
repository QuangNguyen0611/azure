###az login --use-device-code

##terraform block
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.26.0"
    }
  }
}



##provider block
provider "azurerm" {
  subscription_id = var.subscription_id
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
## resource group
resource "azurerm_resource_group" "app_grp" {
  name     = var.resource_group_name
  location = var.location
}

##Vitual Network and Subnet
resource "azurerm_virtual_network" "app_vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.app_grp.location
  resource_group_name = azurerm_resource_group.app_grp.name
}
##Vitual Network and Subnet
resource "azurerm_subnet" "app_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.app_grp.name
  virtual_network_name = azurerm_virtual_network.app_vnet.name
  address_prefixes     = var.subnet_address_prefixes
}

##Public IP
resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  location            = azurerm_resource_group.app_grp.location
  resource_group_name = azurerm_resource_group.app_grp.name
  allocation_method   = "Static" # Updated to meet the requirements
  sku = "Standard" # Updated to meet the requirements
}

#Network Interface
resource "azurerm_network_interface" "my_nic" {
  name                = var.nic_name
  location            = azurerm_resource_group.app_grp.location
  resource_group_name = azurerm_resource_group.app_grp.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.app_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

##torage Account
resource "azurerm_storage_account" "storage_account" {
  name                     = "storageacct${random_string.random_suffix.result}"
  resource_group_name      = azurerm_resource_group.app_grp.name
  location                 = azurerm_resource_group.app_grp.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  tags = var.tags
}

##Creates a storage account with a unique name using a random suffix.
resource "random_string" "random_suffix" {
  length  = 6
  special = false
  upper   = false
}

##Virtual Machine
resource "azurerm_virtual_machine" "my_vm" {
  name                  = var.vm_name
  location              = azurerm_resource_group.app_grp.location
  resource_group_name   = azurerm_resource_group.app_grp.name
  network_interface_ids = [azurerm_network_interface.my_nic.id]
  vm_size               = "Standard_B2s" # Updated to an available size

  storage_os_disk {
    name              = var.os_disk_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.managed_disk_type
  }

  storage_image_reference {
    publisher = var.os_image["publisher"]
    offer     = var.os_image["offer"]
    sku       = var.os_image["sku"]
    version   = var.os_image["version"]
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

##Kubernetes Cluster
resource "azurerm_kubernetes_cluster" "my_aks" {
  name                = var.aks_name
  location            = azurerm_resource_group.app_grp.location
  resource_group_name = azurerm_resource_group.app_grp.name
  dns_prefix          = var.aks_dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.aks_node_count
    vm_size    = "Standard_D2s_v3" # Updated to meet the requirements
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}