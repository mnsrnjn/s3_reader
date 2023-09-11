output "key_arn" {
  description = "The Amazon Resource Name (ARN) of the key"
  value       = try(aws_kms_key.assignment.arn, null)
}

output "key_id" {
  description = "The globally unique identifier for the key"
  value       = try(aws_kms_key.assignment.key_id, null)
}
