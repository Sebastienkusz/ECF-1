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

variable "os_image_tags" {
  description = "Tags of the os image"
  type = map(string)
  default = {
    Version = ""
    }
}
