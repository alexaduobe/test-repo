variable "enabled" {
  description = "Set to false to prevent the module from creating any resources."
  type        = bool
  default     = true
}

variable "name_prefix" {
  description = "Name used by parent"
  type        = string
}

variable "artifact_s3_bucket" {
  description = "Bucket to upload lambda function code to."
  type        = string
}

variable "logs_kms_key" {
  description = "KMS key to encrypt lmabda logs with."
  type        = string
  default     = null
}

variable "region" {
  description = "Default infrastructure region"
  type        = string
  default     = "us-east-2"
}

variable "governed_regions" {
  description = "Comma-delimited list of regions to enable for Security Hub and GuardDuty (leave blank for all regions)"
  type        = string
  default     = "us-east-2,us-east-1,us-west-2,eu-west-1,ap-southeast-2"
}

variable "administrator_account_name" {
  description = "Security operations AWS account name (Audit Manager, SecurityHub, GuardDuty, S3 Storage Lens and Firewall Manager)"
  type        = string
  default     = "Audit"
}

variable "tags" {
  description = "Resource tags defined in the parent module."
  type        = map(string)
  default     = {}
}
