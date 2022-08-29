variable "dns" {
  description = "DNS configuration map"
  type = object({
    domain           = string
    domain_zone_name = string
  })
}

variable "instance_ip" {
  description = "IP for A record"
  type        = string
  default     = ""
}

variable "cname_records_path" {
  description = "IP for A record"
  type        = string
  default     = ""
}

variable "txt_records_path" {
  description = "IP for A record"
  type        = string
  default     = ""
}
