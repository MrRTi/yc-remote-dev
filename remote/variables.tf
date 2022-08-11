variable "token" {
  description = "OAuth token to access Yandex.Cloud."
  type        = string
  sensitive   = true
}

variable "cloud_id" {
  description = "ID of the cloud where Terraform will create resources."
  type        = string
  sensitive   = true
}

variable "folder_id" {
  description = "ID of the folder where resources will be created by default."
  type        = string
  sensitive   = true
}

variable "zone" {
  description = "The availability zone where all cloud resources will be created by default."
  type        = string
  default     = "ru-central1-a"
}

variable "ssh_key_path" {
  description = "Path to ssh key."
  type        = string
  default     = "/yc-terraform/ssh_keys/root_ssh_key"
}

variable "remote_name" {
  description = "The name of virtual machine."
  type        = string
  default     = "workstation-1"
}

variable "username" {
  description = "The name of the user at virtual machine."
  type        = string
  default     = "ubuntu"
}

variable "service_name" {
  description = "The name of service."
  type        = string
  default     = "yc-terraform"
}
