locals {
  domain_contact = {
    contact_type      = "COMPANY"
    first_name        = "Daugherty"
    last_name         = "Support"
    organization_name = "Daugherty Systems, Inc."
    email             = "support@daugherty.com"
    phone_number      = "+1.3144328200"
    address_line_1    = "3 CityPlace Drive"
    address_line_2    = "Suite 400"
    country_code      = "US"
    city              = "Saint Louis"
    state             = "MO"
    zip_code          = "63141"
  }
  dl_root_domain            = "daughertylabs.io"
  daughertylab_io_domain    = "daughertylab.io"
  daughertylab_com_domain   = "daughertylab.com"
  daugherty_labs_com_domain = "daugherty-labs.com"
  tmp_website_domain        = "daugherty.com"
  inf_net_delegation_set = [
    "ns-826.awsdns-39.net.",
    "ns-1120.awsdns-12.org.",
    "ns-72.awsdns-09.com.",
    "ns-1973.awsdns-54.co.uk.",
  ]

  account_id           = data.aws_caller_identity.current.account_id
  nameservers_set_name = "dl-root-dns"
  base_name_servers    = aws_route53_delegation_set.shared.name_servers
  kms_daughertylabs_io = "${module.this.namespace_full}-daughertylabsio-dnssec"
  signing_key_name     = "${local.kms_daughertylabs_io}-ksk"
  signing_status       = var.enable_dnssec ? "SIGNING" : "NOT_SIGNING"
}
