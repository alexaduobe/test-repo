variable "profile" {
  description = "AWS CLI profile to use"
  type        = string
}

variable "region" {
  description = "Default infrastructure region"
  type        = string
  default     = "us-east-2"
}

variable "region_secondary" {
  description = "Seconardy TF state region"
  type        = string
  default     = "us-east-1"
}

variable "ct_management_account_id" {
  description = "Control Tower Management account ID."
  type        = string
}

variable "log_archive_account_id" {
  description = "Control Tower managed Log Archive account ID."
  type        = string
}

variable "audit_account_id" {
  description = "Control Tower managed Audit account ID."
  type        = string
}

variable "aft_management_account_id" {
  description = "Control Tower managed AFT-Management account ID."
  type        = string
}
