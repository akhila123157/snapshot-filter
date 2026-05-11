provider "aws" {
  region = var.region
}

module "iam" {
  source = "./modules/iam"
}

module "sns" {
  source     = "./modules/sns"
  sns_email  = var.sns_email
}

module "lambda" {
  source              = "./modules/lambda"
  role_arn            = module.iam.lambda_role_arn
  function_name       = var.lambda_function_name
  sns_topic_arn       = module.sns.sns_topic_arn
}

module "eventbridge" {
  source            = "./modules/eventbridge"
  lambda_arn        = module.lambda.lambda_arn
  function_name     = var.lambda_function_name
}