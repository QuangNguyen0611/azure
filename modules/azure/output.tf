output "resource_group_name" {
  value = azurerm_resource_group.app_grp.name
}

output "vnet_name" {
  value = azurerm_virtual_network.app_vnet.name
}

output "subnet_name" {
  value = azurerm_subnet.app_subnet.name
}

output "public_ip_address" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "vm_name" {
  value = azurerm_virtual_machine.my_vm.name
}

output "aks_name" {
  value = azurerm_kubernetes_cluster.my_aks.name
}