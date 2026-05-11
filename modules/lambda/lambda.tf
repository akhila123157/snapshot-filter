resource "aws_lambda_function" "snapshot_cleanup" {
  function_name = var.function_name
  role          = var.role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.14"

  filename         = "${path.module}/../../lambda/snapshot.zip"
  source_code_hash = filebase64sha256("${path.module}/../../lambda/snapshot.zip")

  environment {
    variables = {
      SNS_TOPIC_ARN = var.sns_topic_arn
    }
  }
}

variable "role_arn" {}
variable "function_name" {}
variable "sns_topic_arn" {}

output "lambda_arn" {
  value = aws_lambda_function.snapshot_cleanup.arn
}