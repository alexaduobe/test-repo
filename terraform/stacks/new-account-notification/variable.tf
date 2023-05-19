variable "profile" {
  description = "AWS CLI profile to use"
  type        = string
  default     = "iacdevgreen"
}

variable "region" {
  description = "Default infrastructure region"
  type        = string
  default     = "us-east-2"
}

variable "aws_account_id" {
  description = "Devgreen account"
  type = number
  default = 187390017608
  
}