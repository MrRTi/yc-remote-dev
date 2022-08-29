resource "yandex_compute_image" "hdd_image" {
  name          = var.hdd_params.name
  source_image  = var.hdd_params.os_image_id
  min_disk_size = var.hdd_params.size_in_gb
}
