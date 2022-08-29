resource "yandex_vpc_network" "network" {
  name = var.name
}

resource "yandex_vpc_subnet" "subnet" {
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = var.zone
  network_id     = yandex_vpc_network.network.id
}

resource "yandex_vpc_address" "external_address" {
  name = "externalAddress"

  external_ipv4_address {
    zone_id = var.zone
  }
}
