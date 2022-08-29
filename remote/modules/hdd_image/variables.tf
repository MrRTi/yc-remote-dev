variable "hdd_params" {
  description = "HDD params map"
  type = object({
    name        = string
    os_image_id = string
    size_in_gb  = number
  })
}
