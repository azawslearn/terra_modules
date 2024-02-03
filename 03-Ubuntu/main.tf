

resource "azurerm_public_ip" "public_ip_linux" {
  name                = var.public_ip_linux_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "nic_linux" {
  name                = var.nic_linux_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_linux.id
  }
}

resource "azurerm_linux_virtual_machine" "local_k8s_vm" {

  name                            = var.machine_name
  computer_name                   = var.machine_name
  location                        = var.location
  resource_group_name             = var.var.resource_group_name
  network_interface_ids           = [azurerm_network_interface.nic_linux.id]
  size                            = var.machin_size
  disable_password_authentication = true
  admin_username                  = "ivansto"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "ivansto"
    public_key = file("${path.module}/azure.pub")
  }


}
