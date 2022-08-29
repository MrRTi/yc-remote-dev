output "subnet_id" {
  value = yandex_vpc_subnet.subnet.id
}

output "external_ipv4_address" {
  value = yandex_vpc_address.external_address.external_ipv4_address[0].address
}
