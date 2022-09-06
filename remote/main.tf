locals {
  instance_key_file = join(".", [join("/", ["", var.service_name, var.ssh_key_path]), "pub"])
}

resource "yandex_compute_disk" "disk" {
  zone     = var.zone

  name     = var.hdd.name
  type     = var.hdd.type
  size     = var.hdd.size_in_gb

  image_id = length(var.hdd.backup_image_id) > 0 ? var.hdd.backup_image_id : var.hdd.os_image_id
}

resource "yandex_compute_instance" "remote" {
  name = var.remote_name
  zone = var.zone

  platform_id               = var.instance.vm_platform
  allow_stopping_for_update = var.instance.allow_stopping_for_update

  resources {
    cores         = var.instance.number_of_cores
    memory        = var.instance.memory_in_gb
    core_fraction = var.instance.performance_percantage
  }

  boot_disk {
    disk_id = yandex_compute_disk.disk.id
  }

  network_interface {
    subnet_id      = module.network.subnet_id
    nat_ip_address = module.network.external_ipv4_address
    nat            = true
  }

  metadata = {
    ssh-keys = join(":", [var.username, file(local.instance_key_file)])
  }
}

module "network" {
  source = "./modules/network"

  name = var.network.name
  zone = var.network.zone
}

module "dns" {
  count = length(var.dns.domain) > 0 ? 1 : 0

  source = "./modules/dns"

  dns         = var.dns
  instance_ip = module.network.external_ipv4_address

  cname_records_path = "${path.module}/dns_records/cname_records.json"
  txt_records_path   = "${path.module}/dns_records/txt_records.json"
}
