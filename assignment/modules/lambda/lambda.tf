data "archive_file" "lambda_package" {
  type        = "zip"
  source_file = "${path.module}/files/ec2_stop_start.py"  # Path to the Python file
  output_path = "${path.module}/lambda_function.zip"  # Output ZIP file
}

resource "aws_lambda_function" "ec2_scheduler" {
  filename         = data.archive_file.lambda_package.output_path
  function_name    = "${local.name_suffix}-ec2-scheduler"
  role             = aws_iam_role.lambda_ec2_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  environment {
    variables = {
      TAG_KEY   = "AutoSchedule"
      TAG_VALUE = "True"
    }
  }
  depends_on = [aws_iam_role_policy_attachment.lambda_ec2_attach]
}

resource "aws_lambda_permission" "allow_cloudwatch_start" {
  statement_id  = "AllowExecutionFromCloudWatchStart"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ec2_scheduler.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.start_instances_rule.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_stop" {
  statement_id  = "AllowExecutionFromCloudWatchStop"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ec2_scheduler.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.stop_instances_rule.arn
}