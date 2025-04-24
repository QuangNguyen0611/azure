variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = "1aa30304-f3cf-446b-848a-f0c77bf1d964"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "app-grp"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "Southeast Asia"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "my-vnet"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "my-subnet"
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "public_ip_name" {
  description = "Name of the public IP"
  type        = string
  default     = "my-public-ip"
}

variable "allocation_method" {
  description = "IP allocation method for public IP"
  type        = string
  default     = "Static"
}

variable "nic_name" {
  description = "Name of the network interface"
  type        = string
  default     = "my-nic"
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
  default     = "my-vm"
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
  default     = "Standard_DS1_v2"
}

variable "os_disk_name" {
  description = "Name of the OS disk"
  type        = string
  default     = "my-os-disk"
}

variable "managed_disk_type" {
  description = "Managed disk type for the VM"
  type        = string
  default     = "Standard_LRS"
}

variable "os_image" {
  description = "OS image configuration for the VM"
  type        = map(string)
  default = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "adminuser"
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}

variable "aks_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "my-aks"
}

variable "aks_dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
  default     = "myaks"
}

variable "aks_node_count" {
  description = "Number of nodes in the AKS cluster"
  type        = number
  default     = 1
}

variable "aks_vm_size" {
  description = "VM size for the AKS cluster nodes"
  type        = string
  default     = "Standard_DS1_v2"
}

variable "account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Storage account replication type"
  type        = string
  default     = "LRS"
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
  default     = {
    Environment = "Production"
  }
}