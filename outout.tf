output "jenkins_vm_private_ip" {
  description = "The private IP address of the Jenkins VM"
  value       = azurerm_network_interface.gamut_jenkins_nic.private_ip_address
}

output "jenkins_vm_public_ip" {
  description = "The public IP address of the Jenkins VM"
  value       = azurerm_public_ip.jenkins_vm_pip.ip_address
}

output "aks_cluster_name" {
  description = "The name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.gamut_aks_cluster.name
}

output "acr_login_server" {
  description = "The login server URL for the Azure Container Registry"
  value       = azurerm_container_registry.gamut_acr.login_server
}

output "acr_name" {
  description = "The name of the Azure Container Registry"
  value       = azurerm_container_registry.gamut_acr.name
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.gamut_prod_rg.name
}
