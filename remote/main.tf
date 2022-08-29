locals {
  instance_key_file = join(".", [join("/", ["", var.service_name, var.ssh_key_path]), "pub"])
}

moved {
  from = yandex_compute_instance.workstation
  to   = yandex_compute_instance.remote
}

moved {
  from = yandex_vpc_network.network
  to   = module.network.yandex_vpc_network.network
}

moved {
  from = yandex_vpc_subnet.ws-subnet
  to   = module.network.yandex_vpc_subnet.subnet
}

moved {
  from = yandex_vpc_address.ws-address
  to   = module.network.yandex_vpc_address.external_address
}

moved {
  from = yandex_compute_image.ws-hdd-image
  to   = module.hdd_image.yandex_compute_image.hdd_image
}

module "hdd_image" {
  source = "./modules/hdd_image"

  hdd_params = var.hdd
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
    initialize_params {
      size     = var.hdd.size_in_gb
      image_id = module.hdd_image.image_id
    }
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
