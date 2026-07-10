# Define output values for later reference
output "resource_group_name" {
  description = "Name of the Azure resource group."
  value       = azurerm_resource_group.rg.name
}

output "vm_name" {
  description = "Name of the Azure Linux virtual machine."
  value       = azurerm_linux_virtual_machine.webserver.name
}

output "nic_name" {
  description = "Name of the network interface."
  value       = azurerm_network_interface.webserver.name
}

output "public_ip" {
  description = "Public IP address assigned to the web server."
  value       = azurerm_linux_virtual_machine.webserver.public_ip_address
}
