variable "project_rg" {
  description = "The resource group of the project"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "client_id" {
  description = "The client ID of the application"
  type        = string
  default     = "${env("ARM_CLIENT_ID")}"
}

variable "client_secret" {
  description = "The client secret of the application"
  type        = string
  default     = "${env("ARM_CLIENT_SECRET")}"
}

variable "tenant_id" {
  description = "The tenant ID of the application"
  type        = string
  default     = "${env("ARM_TENANT_ID")}"
}

variable "subscription_id" {
  description = "The subscription ID of the application"
  type        = string
  default     = "${env("ARM_SUBSCRIPTION_ID")}"
}

variable "os_image_tags_Version" {
  description = "Version Tag of the os image"
  type        = string
}

variable "ssh_user_name" {
  description = "User name with sudo"
  type        = string
}

variable "ssh_key_name" {
  description = "Ssh key of user"
  type        = string
}