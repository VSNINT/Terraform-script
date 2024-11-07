# Azure Resource Group
resource "azurerm_resource_group" "gamut_prod_rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = "production"
    project     = "Gamut"
  }
}

# Virtual Network
resource "azurerm_virtual_network" "gamut_vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.gamut_prod_rg.location
  resource_group_name = azurerm_resource_group.gamut_prod_rg.name
  address_space       = [var.vnet_address_space]

  tags = {
    environment = "production"
    project     = "Gamut"
  }
}

# Subnet for AKS
resource "azurerm_subnet" "gamut_subnet_aks" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.gamut_prod_rg.name
  virtual_network_name = azurerm_virtual_network.gamut_vnet.name
  address_prefixes     = [var.subnet_address_prefix]
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "gamut_aks_cluster" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.gamut_prod_rg.location
  resource_group_name = azurerm_resource_group.gamut_prod_rg.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = var.node_pool_name
    node_count = var.node_count
    vm_size    = var.vm_size
    type       = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
  network_plugin    = "azure"
  load_balancer_sku = "standard"  # Ensure this value is exactly "Standard"
  network_policy    = "azure"
}


  depends_on = [azurerm_subnet.gamut_subnet_aks]

  tags = {
    environment = "production"
    project     = "Gamut"
  }
}

# Azure Container Registry (ACR)
resource "azurerm_container_registry" "gamut_acr" {
  name                = var.acr_name
  location            = azurerm_resource_group.gamut_prod_rg.location
  resource_group_name = azurerm_resource_group.gamut_prod_rg.name
  sku                 = var.acr_sku
  admin_enabled       = true

  tags = {
    environment = "production"
    project     = "Gamut"
  }
}

# Public IP Address for Jenkins VM
resource "azurerm_public_ip" "jenkins_vm_pip" {
  name                = "jenkinsPublicIP"
  resource_group_name = azurerm_resource_group.gamut_prod_rg.name
  location            = azurerm_resource_group.gamut_prod_rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Network Interface for Jenkins VM
resource "azurerm_network_interface" "gamut_jenkins_nic" {
  name                = var.nic_name
  location            = azurerm_resource_group.gamut_prod_rg.location
  resource_group_name = azurerm_resource_group.gamut_prod_rg.name

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = azurerm_subnet.gamut_subnet_aks.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jenkins_vm_pip.id
  }

  tags = {
    environment = "production"
    project     = "Gamut"
  }
}

# Jenkins VM
resource "azurerm_linux_virtual_machine" "gamut_jenkins_vm" {
  name                  = var.vm_name
  location              = azurerm_resource_group.gamut_prod_rg.location
  resource_group_name   = azurerm_resource_group.gamut_prod_rg.name
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.gamut_jenkins_nic.id]
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  tags = {
    environment = "production"
    project     = "Gamut"
  }
}
