# ---------------------------------
# Variabili per l'autenticazione OpenStack (Basate sul tuo terraform.tfvars)
# ---------------------------------
variable "os_auth_url" {
  description = "OpenStack Identity Service endpoint"
  type        = string
}

variable "os_id" {
  description = "OpenStack ID"
  type        = string
}

variable "os_username" {
  description = "OpenStack Username"
  type        = string
}

variable "os_password" {
  description = "OpenStack Password"
  type        = string
  sensitive   = true
}

variable "os_tenant_id" {
  description = "OpenStack Tenant ID (Project ID)"
  type        = string
}

variable "os_token" {
  description = "OpenStack authentication token"
  type        = string
  sensitive   = true
}

# ---------------------------------
# Variabili per le risorse VM
# ---------------------------------
variable "image_name" {
  description = "Nome dell'immagine da usare per le VM"
  type        = string
}

variable "flavor_name" {
  description = "Flavor (dimensione) delle VM"
  type        = string
}

variable "flavor_db" {
  description = "Flavor dedicato per la VM PostgreSQL (default: medium)"
  type        = string
  default     = "medium"
}

variable "ssh_public_key" {
  description = "Chiave pubblica SSH da iniettare nel Keypair"
  type        = string
}

variable "bastion_ip" {
  description = "IP pubblico del Bastion Host (se pre-assegnato o statico)"
  type        = string
}

# Variabile per l’IP del controller Terraform
variable "controller_ip" {
  description = "IP privato della macchina controller Terraform per consentire accesso a PostgreSQL"
  type        = string
}
