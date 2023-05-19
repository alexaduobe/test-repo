locals {
  toplevel_ous   = [for ou in data.aws_organizations_organizational_units.dl.children : ou if ou.name != "Suspended"]
  sandbox_ous    = [for ou in local.toplevel_ous : ou if ou.name == "Sandboxes"]
  nonsandbox_ous = [for ou in local.toplevel_ous : ou if ou.name != "Sandboxes"]
}
