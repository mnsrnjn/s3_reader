variable "description" {
  description = "Description of your Lambda Function (or Layer)"
  type        = string
  default     = ""
}
variable "handler" {
  description = "Lambda Function entrypoint in your code"
  type        = string
  default     = ""
}

variable "kms_key_arn" {
  description = "The ARN of KMS key to use by your Lambda Function"
  type        = string
  default     = null
}
variable "tags" {
  description = "A map of tags to assign to resources."
  type        = map(string)
  default     = {}
}

variable "runtime" {
  description = "Lambda Function runtime"
  type        = string
  default     = "python3.8"
}

variable "function_name" {
  description = "A unique name for your Lambda Function"
  type        = string
  default     = "lambda_for_assignment"
}

variable "schedule_expression" {
  description = "schedule details to trigger the lambda"
  type        = string
  default     = "cron(0 2 ? * 7 *)"
}

variable "bucket_name" {
  description = " The name of the bucket in which the files will be processed."
  type        = string
  default     = null
}

variable "prefix" {
  description = "the patern to process the files"
  type        = string
  default     = null
}