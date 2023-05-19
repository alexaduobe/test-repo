variable "profile" {
  description = "AWS CLI profile to use"
  type        = string
}

variable "region" {
  description = "Default infrastructure region"
  type        = string
  default     = "us-east-2"
}

variable "enable_dnssec" {
  description = "Set to true to enable DNSSEC."
  type        = bool
  default     = false
}
