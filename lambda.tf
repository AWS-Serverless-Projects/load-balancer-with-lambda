data "template_file" "lambda_assume_role_policy" {
  template = file("./policies/lambda_assume_role.json")
}

resource "aws_iam_role" "lambda-assume-role-policy" {
  assume_role_policy = data.template_file.lambda_assume_role_policy.rendered
}

resource "aws_iam_role_policy_attachment" "lambda-policy-role-attachment" {
  policy_arn =  "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role = aws_iam_role.lambda-assume-role-policy.name
}

resource "aws_lambda_function" "lambda" {
  function_name = "demo-alb-target-function"
  filename = "lambda.zip"
  handler = "index.handler"
  role = aws_iam_role.lambda-assume-role-policy.arn
  runtime = "nodejs12.x"
  source_code_hash = filebase64sha256("lambda.zip")
}

resource "aws_lambda_permission" "with_lb" {
  statement_id  = "AllowExecutionFromlb"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.arn
  principal     = "elasticloadbalancing.amazonaws.com"
  source_arn    = aws_lb_target_group.lambda-target-group.arn
}
