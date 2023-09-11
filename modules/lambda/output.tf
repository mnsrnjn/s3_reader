output "function_arn" {
  description = "The ARN of the Lambda Function"
  value       = try(aws_lambda_function.s3_reader.arn, "")
}

output "function_name" {
  description = "The name of the Lambda Function"
  value       = try(aws_lambda_function.s3_reader.function_name, "")
}

variable "kms_key_id" {
  description = "KMS key to be used to encrypt the contects (either use data or output to pass it)"
  type        = string
  default     = null
}