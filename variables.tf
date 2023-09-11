variable "access_key" {
  description = "access key for logging in to account"
  type        = string
}

variable "secret_key" {
  description = "secret ey to login to aws account to create resource"
  type        = string
}

variable "bucket_name" {
  description = "The name of the bucket. If omitted, Terraform will assign a random, unique name."
  type        = string
  default     = "assignment-testing-for-s3read"
}

variable "prefix" {
  description = "The name of the prefix where the files are uploaded."
  type        = string
  default     = "assignment/"
}
variable "aws_region" {
  description = "The location/region where the resource is created"
  type        = string
  default     = "eu-west-1"
}


variable "kms_master_key_id" {
  description = "KMS key to be used to encrypt the contects (either use data or output to pass it)"
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the bucket."
  type        = map(string)
  default     = {
    "usage" = "assignment"
    "createdby"  = "manas"
  }
}

variable "description" {
  description = "The description of the key as viewed in AWS console"
  type        = string
  default     = "KMS key to encrypt the contents"
}

variable "deletion_window_in_days" {
  description = "The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key. If you specify a value, it must be between `7` and `30`, inclusive. If you do not specify a value, it defaults to `30`"
  type        = number
  default     = 10
}

variable "enable_key_rotation" {
  description = "Specifies whether key rotation is enabled. Defaults to `true`"
  type        = bool
  default     = true
}

variable "is_enabled" {
  description = "Specifies whether the key is enabled. Defaults to `true`"
  type        = bool
  default     = true
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
  default     = "rate(5 minutes)"
}
