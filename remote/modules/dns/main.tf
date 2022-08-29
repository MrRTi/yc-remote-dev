locals {
  cname_records = fileexists(var.cname_records_path) ? templatefile(
      var.cname_records_path,
      { domain = var.dns.domain }
    ) : "{}"

  txt_records = fileexists(var.txt_records_path) ? templatefile(
      var.txt_records_path,
      { domain = var.dns.domain }
    ) : "{}"
}
resource "yandex_dns_zone" "zone" {
  name        = var.dns.domain_zone_name
  description = "Managed by terraform"

  zone   = "${var.dns.domain}."
  public = true
}

resource "yandex_dns_recordset" "dev_a_record" {
  zone_id = yandex_dns_zone.zone.id
  name    = "dev.${var.dns.domain}."
  type    = "A"
  ttl     = "600"
  data    = [var.instance_ip]
}

resource "yandex_dns_recordset" "cname_record" {
  for_each = jsondecode(local.cname_records)

  zone_id = yandex_dns_zone.zone.id
  name    = each.key
  type    = "CNAME"
  ttl     = "600"
  data    = each.value.records
}

resource "yandex_dns_recordset" "txt_record" {
  for_each = jsondecode(local.txt_records)

  zone_id = yandex_dns_zone.zone.id
  name    = each.key
  type    = "TXT"
  ttl     = "600"
  data    = each.value.records
}
