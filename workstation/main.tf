locals {
  os_image_id    = "fd8vmcue7aajpmeo39kk"
  hdd_size_in_gb = 30

  vm_platform            = "standard-v1"
  number_of_cores        = 2
  memory_in_gb           = 6
  performance_percantage = 100
}

resource "yandex_compute_image" "ws-hdd-image" {
  name          = "ws-hdd-image"
  source_image  = local.os_image_id
  min_disk_size = local.hdd_size_in_gb
}

resource "yandex_compute_instance" "workstation" {
  name        = var.workstation_name
  platform_id = local.vm_platform
  zone        = var.zone

  resources {
    cores         = local.number_of_cores
    memory        = local.memory_in_gb
    core_fraction = local.performance_percantage
  }

  boot_disk {
    initialize_params {
      size     = local.hdd_size_in_gb
      image_id = yandex_compute_image.ws-hdd-image.id
    }
  }

  network_interface {
    subnet_id      = yandex_vpc_subnet.ws-subnet.id
    nat            = true
    nat_ip_address = yandex_vpc_address.ws-address.external_ipv4_address[0].address
  }

  metadata = {
    ssh-keys = join(":", [var.username, file(join(".", [join("/", ["", var.service_name, var.ssh_key_path]), "pub"]))])
  }
}

resource "yandex_vpc_network" "network" {
  name = "ws-network"
}

resource "yandex_vpc_subnet" "ws-subnet" {
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = var.zone
  network_id     = yandex_vpc_network.network.id
}

resource "yandex_vpc_address" "ws-address" {
  name = "externalAddress"

  external_ipv4_address {
    zone_id = var.zone
  }
}
