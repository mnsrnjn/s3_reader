data "aws_partition" "current" {}
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}





data "archive_file" "archive_file" {
  type        = "zip"
  source_file = "assignment.py"
  output_path = "assignment.zip"
}

resource "aws_lambda_function" "s3_reader" {
  filename         = "assignment.zip"  # Your Lambda deployment package
  function_name    =  var.function_name
  description      = var.description
  role             = aws_iam_role.lambda_role.arn
  handler          = "assignment.lambda_handler"
  runtime          = var.runtime
  kms_key_arn      = var.kms_key_arn

  environment {
    variables = {
      S3_BUCKET = var.bucket_name ,
      S3_PREFIX    = var.prefix,
    }
  }
}


data "aws_iam_policy_document" "policy" {
  statement {
    sid    = ""
    effect = "Allow"

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role"
  assume_role_policy = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_policy_attachment" "lambda_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"  # Attach a policy that allows S3 read access
  roles      = [aws_iam_role.lambda_role.name]
  name               = "lambda_role_attachment"
}

resource "aws_lambda_permission" "allow_execution" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_reader.function_name
  principal     = "s3.amazonaws.com"
}

# Create our schedule
resource "aws_cloudwatch_event_rule" "assignment_lambda_trigger" {
  name                = "triggering_lamda"
  description         = "Fires 2 AM of  first saturday of month "
  #schedule_expression = "corn(0 2 1,2,3,4,5,6,7 * 7 )"
  schedule_expression = var.schedule_expression
}

# Trigger our lambda based on the schedule
resource "aws_cloudwatch_event_target" "trigger_lambda_on_schedule" {
  rule      = aws_cloudwatch_event_rule.assignment_lambda_trigger.name
  target_id = "lambda"
  arn       = aws_lambda_function.s3_reader.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_split_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_reader.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.assignment_lambda_trigger.arn
}


resource "aws_kms_grant" "assignment" {
  name              = "kms-grant-to-lambda"
  key_id            = var.kms_key_id
  grantee_principal = aws_iam_role.lambda_role.arn
  operations        = [ "Decrypt"]

}