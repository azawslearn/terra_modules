output "public_ip_address" {
  value = azurerm_public_ip.public_ip_linux.ip_address
}

output "private_ip_address" {
  value = azurerm_network_interface.nic_linux.ip_configuration[0].private_ip_address
}
