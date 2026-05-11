variable "region" {
  default = "us-east-1"
}

variable "lambda_function_name" {
  default = "snapshot-cleanup"
}

variable "sns_email" {
  description = "Email for SNS notifications"
}