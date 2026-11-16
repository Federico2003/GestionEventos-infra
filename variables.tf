variable "account_id" {
  description = "ID de la cuenta de Cloudflare"
  type        = string
}

variable "api_token" {
  description = "API token con permisos de Workers Scripts, D1 y Cloudflare Pages (Edit)"
  type        = string
  sensitive   = true
}

variable "project_name" {
  description = "Prefijo de nombres de los recursos"
  type        = string
  default     = "planora"
}

variable "environments" {
  description = "Ambientes a crear (sufijo de los recursos)"
  type        = set(string)
  default     = ["dev", "prod"]
}
