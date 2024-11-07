variable "resource_group_name" {
  type    = string
  default = "Gamut-Prod-RG"
}

variable "location" {
  type    = string
  default = "CentralIndia"
}

variable "vnet_name" {
  type    = string
  default = "gamut-vnet"
}

variable "vnet_address_space" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_name" {
  type    = string
  default = "gamut-subnet"
}

variable "subnet_address_prefix" {
  type    = string
  default = "10.0.1.0/24"
}

variable "aks_cluster_name" {
  type    = string
  default = "gamut-aks-cluster"
}

variable "dns_prefix" {
  type    = string
  default = "gamutaks"
}

variable "node_pool_name" {
  type    = string
  default = "default"
}

variable "node_count" {
  type    = number
  default = 3
}

variable "vm_size" {
  type    = string
  default = "Standard_D2as_v5"
}


variable "load_balancer_sku" {
  description = "The SKU for the load balancer in the AKS cluster"
  type        = string
  default     = "standard"  # This could also be "Basic" depending on your requirement
}


variable "acr_name" {
  type    = string
  default = "gamutacr12345"
}

variable "acr_sku" {
  type    = string
  default = "Basic"
}

variable "nic_name" {
  type    = string
  default = "gamut-jenkins-nic"
}

variable "ip_configuration_name" {
  type    = string
  default = "jenkins-ip-config"
}
variable "vm_name" {
  description = "The name of the Jenkins VM"
  type        = string
  default     = "jenkins-vm"  # Replace with your desired VM name
}


variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "admin_password" {
  type    = string
  default = "AKpatel@1122"
}

variable "os_disk_type" {
  type    = string
  default = "Premium_LRS"
}

variable "image_publisher" {
  type    = string
  default = "Canonical"
}

variable "image_offer" {
  type    = string
  default = "UbuntuServer"
}

variable "image_sku" {
  type    = string
  default = "20.04-LTS"
}

variable "image_version" {
  type    = string
  default = "20.04.202310040"  # Replace with specific version
}
