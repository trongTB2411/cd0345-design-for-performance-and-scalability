provider "aws" {
    access_key = "ASIA52OUDJN2FEP3NGWL"
    secret_key = "bYPF2/ORW2EaGLQ2fvqrtqmOzRA2vaO90cvHLNqL"
    token = "FwoGZXIvYXdzEPn//////////wEaDAzIZjRQfM0ODsib9SLVAeldKgyyTWeo0ENjoaGWbabUhH4sDiB6SJvHG2VQuF+Id1MgpyfKhLDvzIpvv2lcnYeF5cQaNsISuIwthQbNPpPnkhQHwm6+VhrtJH7eXNFqFDfNXnDfXOCQ66ugL0iqaqAOA8vVkdR0xbNkpOSnAb2ul4EGZA7XJBgZraa6zQj7PMRtzDatQDUVAJqMPa7+O6BV1vqPEkBFrHZSmMBJCGx8ha4xlcTMwGd1ade5vzJzxj1mYblJJT1kwlBY8u71bnHGtZBR4ByJcy4d3RL3+ksDYjKvyCj666ClBjItoe5x/pqMfTcUz4o3e/hziK2cn/n9XiAKC691SfWdkE850qFQaYzRYpGfzBnq"
    region = var.aws_region
}

data "archive_file" "exercise2_lambda" {
    type = "zip"
    source_file = "${path.module}/greet_lambda.py"
    output_path = "${path.module}/greet_lambda.zip"
}

# resource "random_pet" "lambda_bucket_name" {
#   prefix = "learn-terraform-functions"
#   length = 4
# }

# resource "aws_s3_bucket" "lambda_bucket" {
#   bucket = random_pet.lambda_bucket_name.id
# }

# resource "aws_s3_object" "lambda_exercise" {
#     bucket = aws_s3_bucket.lambda_bucket.id

#     key = "greet_lambda.zip"
#     source = data.archive_file.exercise2_lambda.output_path
# }

resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "terraform_lambda_function" {
    function_name = "Exercise2"

    # s3_bucket = aws_s3_bucket.lambda_bucket.id
    # s3_key = aws_s3_object.lambda_exercise.key


    handler = "greet_lambda.lambda_handler"
    runtime = "python3.8"

    filename = "${path.module}/greet_lambda.zip"
    role = aws_iam_role.lambda_exec.arn
}

resource "aws_cloudwatch_log_group" "Exercise2" {
    name = "/aws/lambda/${aws_lambda_function.terraform_lambda_function.function_name}"

    retention_in_days =3
}
