resource "aws_cloudwatch_event_rule" "start_instances_rule" {
  name        = "${local.name_suffix}-StartInstancesRule"
  description = "Trigger Lambda at 9 AM daily"
  schedule_expression = "cron(0 9 * * ? *)"
}

resource "aws_cloudwatch_event_rule" "stop_instances_rule" {
  name        = "${local.name_suffix}-StopInstancesRule"
  description = "Trigger Lambda at 5 PM daily"
  schedule_expression = "cron(0 17 * * ? *)"
}

resource "aws_cloudwatch_event_target" "start_target" {
  rule      = aws_cloudwatch_event_rule.start_instances_rule.name
  target_id = "StartLambda"
  arn       = aws_lambda_function.ec2_scheduler.arn
}

resource "aws_cloudwatch_event_target" "stop_target" {
  rule      = aws_cloudwatch_event_rule.stop_instances_rule.name
  target_id = "StopLambda"
  arn       = aws_lambda_function.ec2_scheduler.arn
}