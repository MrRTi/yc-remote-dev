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
  default     = "/infra/ssh_keys/root_ssh_key"
}

variable "service_name" {
  description = "The name of service."
  type        = string
  default     = "infra"
}

variable "remote_name" {
  description = "The name of virtual machine."
  type        = string
  default     = "remote"
}

variable "username" {
  description = "The name of the user at virtual machine."
  type        = string
  default     = "ubuntu"
}

variable "network_name" {
  description = "Network name"
  type        = string
  default     = "ws-network"
}

variable "hdd" {
  description = "HDD params map"
  type = object({
    name        = string
    os_image_id = string
    size_in_gb  = number
    type        = string

    backup_image_id = string
  })
}

variable "instance" {
  description = "Instance params map"
  type = object({
    vm_platform               = string
    number_of_cores           = number
    memory_in_gb              = number
    performance_percantage    = number
    allow_stopping_for_update = bool
  })
}

variable "network" {
  description = "Network configuration map"
  type = object({
    name = string
    zone = string
  })
}

variable "dns" {
  description = "DNS configuration map"
  type = object({
    domain           = string
    domain_zone_name = string
  })
}
