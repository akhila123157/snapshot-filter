resource "aws_sns_topic" "snapshot_topic" {
  name = "snapshot-alerts"
}

resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.snapshot_topic.arn
  protocol  = "email"
  endpoint  = var.sns_email
}

variable "sns_email" {}

output "sns_topic_arn" {
  value = aws_sns_topic.snapshot_topic.arn
}