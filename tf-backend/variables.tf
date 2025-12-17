variable "pg_host" {
  description = "IP privato della VM PostgreSQL"
  type        = string
}

variable "pg_port" {
  description = "Porta PostgreSQL"
  type        = number
  default     = 5432
}

variable "pg_db" {
  description = "Nome del database per Terraform state"
  type        = string
  default     = "tf_state"
}

variable "pg_user" {
  description = "Utente PostgreSQL per Terraform state"
  type        = string
  default     = "tf_user"
}

variable "pg_password" {
  description = "Password dell’utente PostgreSQL"
  type        = string
  # test password
  default     = "tf_password"
}

variable "os_auth_url" {
  description = "OpenStack Identity Service endpoint"
  type        = string
}

variable "os_token" {
  description = "Token OpenStack"
  type        = string
  sensitive   = true
}

variable "os_tenant_id" {
  description = "OpenStack Tenant ID"
  type        = string
}
