variable "datacenter_prefix_list_name" {
  description = "Name to assign to VPC managed prefix list for the DBS network egress."
  type        = string
}

variable "tags" {
  description = "Resource tags defined in the parent module."
  type        = map(string)
  default     = {}
}
