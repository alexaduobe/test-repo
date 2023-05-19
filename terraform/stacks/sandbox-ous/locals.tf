locals {
  sandbox_ou = [for ou in data.aws_organizations_organizational_units.dl.children : ou if ou.name == "Sandboxes"]
}
