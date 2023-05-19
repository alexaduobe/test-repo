variable "profile" {
  description = "AWS CLI profile to use"
  type        = string
}

variable "enable_dnssec" {
  description = "Set to true to enable DNSSEC."
  type        = bool
  default     = false
}
