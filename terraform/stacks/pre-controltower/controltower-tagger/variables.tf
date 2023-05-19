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

variable "tags" {
  description = "Resource tags defined in the parent module."
  type        = map(string)
  default     = {}
}
