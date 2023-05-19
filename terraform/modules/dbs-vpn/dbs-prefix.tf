resource "aws_ec2_managed_prefix_list" "dbs_dc" {
  name           = var.datacenter_prefix_list_name
  address_family = "IPv4"
  max_entries    = 8
  entry {
    cidr        = "192.94.40.70/32"
    description = "STL datacenter"
  }

  tags = merge(var.tags, {
    Name = var.datacenter_prefix_list_name
  })
}
