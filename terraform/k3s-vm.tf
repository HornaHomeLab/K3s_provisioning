# Configure the Vault provider with AppRole authentication
provider "vault" {
  address = "http://vault.horna.local"

  # AppRole authentication
  auth_login {
    path = "auth/approle/login"
    parameters = {
      role_id   = var.vault_role_id
      secret_id = var.vault_secret_id
    }
  }

}

# Retrieve Proxmox credentials from Vault
data "vault_generic_secret" "proxmox_credentials" {
  path = "Infrastructure-Access/proxmox"
}


module "ubuntu_vm_201" {
  source = "github.com/HornaHomeLab/Terraform_Modules/Ubuntu-VM"

  proxmox_api_token_id     = data.vault_generic_secret.proxmox_credentials.data["terraform-token-id"]
  proxmox_api_token_secret = data.vault_generic_secret.proxmox_credentials.data["terraform-secret"]
  proxmox_api_url          = data.vault_generic_secret.proxmox_credentials.data["terraform-api-url"]
  ssh_pubkey               = data.vault_generic_secret.proxmox_credentials.data["id_rsa.pub"]
  default_password         = data.vault_generic_secret.proxmox_credentials.data["root-user-password"]

  vmid         = 201
  vm_name      = "k3s-server"
  vm_desc      = "k3s cluster to learn k8s"
  tags         = ["k3s"]
  memory       = "8192"
  ip_address   = "10.0.10.201"
  cidr_netmask = "24"
  gateway      = "10.0.10.1"
  dns_servers  = ["10.0.10.10", "1.1.1.1", "8.8.8.8"]
}
module "ubuntu_vm_202" {
  source = "github.com/HornaHomeLab/Terraform_Modules/Ubuntu-VM"

  proxmox_api_token_id     = data.vault_generic_secret.proxmox_credentials.data["terraform-token-id"]
  proxmox_api_token_secret = data.vault_generic_secret.proxmox_credentials.data["terraform-secret"]
  proxmox_api_url          = data.vault_generic_secret.proxmox_credentials.data["terraform-api-url"]
  ssh_pubkey               = data.vault_generic_secret.proxmox_credentials.data["id_rsa.pub"]
  default_password         = data.vault_generic_secret.proxmox_credentials.data["root-user-password"]

  vmid         = 202
  vm_name      = "k3s-agent"
  vm_desc      = "k3s cluster to learn k8s"
  tags         = ["k3s"]
  memory       = "8192"
  ip_address   = "10.0.10.202"
  cidr_netmask = "24"
  gateway      = "10.0.10.1"
  dns_servers  = ["10.0.10.10", "1.1.1.1", "8.8.8.8"]
}
module "ubuntu_vm_203" {
  source = "github.com/HornaHomeLab/Terraform_Modules/Ubuntu-VM"

  proxmox_api_token_id     = data.vault_generic_secret.proxmox_credentials.data["terraform-token-id"]
  proxmox_api_token_secret = data.vault_generic_secret.proxmox_credentials.data["terraform-secret"]
  proxmox_api_url          = data.vault_generic_secret.proxmox_credentials.data["terraform-api-url"]
  ssh_pubkey               = data.vault_generic_secret.proxmox_credentials.data["id_rsa.pub"]
  default_password         = data.vault_generic_secret.proxmox_credentials.data["root-user-password"]

  vmid         = 203
  vm_name      = "k3s-agent"
  vm_desc      = "k3s cluster to learn k8s"
  tags         = ["k3s"]
  memory       = "8192"
  ip_address   = "10.0.10.203"
  cidr_netmask = "24"
  gateway      = "10.0.10.1"
  dns_servers  = ["10.0.10.10", "1.1.1.1", "8.8.8.8"]
}

