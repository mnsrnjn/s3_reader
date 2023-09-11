# data "aws_partition" "current" {}
# data "aws_region" "current" {}
# data "aws_caller_identity" "current" {}




module "assignment_kms" {
  source = "./modules/kms"


  description               = "kms to enable the encryption"
  deletion_window_in_days   = 7
  enable_key_rotation       = true
  is_enabled                = true

}

module "assignment_bucket" {
  source = "./modules/s3"

  bucket_name       = "kpn-assignment-techbase"
  kms_master_key_id =  module.assignment_kms.key_id


}

module "assignment_lambda" {
  source = "./modules/lambda"

  function_name         = "lambdafunctiontoreadcontectsfroms3"
  description           = "lambda function to read the contents of the txt files uploaded in s3"
  runtime               = "python3.8"
  kms_key_arn           = module.assignment_kms.key_arn
  kms_key_id            = module.assignment_kms.key_id
  bucket_name           = "kpn-assignment-techbase"
  prefix                = "assignment/"
  schedule_expression   = "cron(0 2 ? * 7 *)"

}

