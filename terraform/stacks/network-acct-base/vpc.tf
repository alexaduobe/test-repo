module "dbsvpn" {
  source = "../../modules/dbs-vpn"

  datacenter_prefix_list_name = local.prefix_list_name
  tags                        = module.this.tags
}
