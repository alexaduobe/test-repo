variable "profile" {
  description = "AWS CLI profile to use"
  type        = string
}

variable "region" {
  description = "Default infrastructure region"
  type        = string
  default     = "us-east-2"
}

variable "delete" {
  description = "Set to true to delete resources created by null provider during previous executions."
  type        = bool
  default     = false
}

