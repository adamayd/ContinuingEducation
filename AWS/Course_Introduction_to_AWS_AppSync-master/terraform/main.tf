provider "aws" {
  region = "us-east-2"
}
data "aws_iam_policy_document" "cross_account_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.principal_arns
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_budgets_budget" "testing-only" {
  name              = "monthly-budget"
  budget_type       = "COST"
  limit_amount      = "20.00"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2022-04-01_00:01"
}

resource "aws_iam_policy" "ddb-access-policy" {
  name        = "DdbAccess"
  description = "DynamoDB Access"

  policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "QuizBizQuestionTable",
      "Effect": "Allow",
      "Action": [
        "dynamodb:BatchGetItem",
        "dynamodb:BatchWriteItem",
        "dynamodb:PutItem",
        "dynamodb:DeleteItem",
        "dynamodb:GetItem",
        "dynamodb:Scan",
        "dynamodb:Query",
        "dynamodb:UpdateItem"
      ],
      "Resource": [
        "arn:aws:dynamodb:*:*:table/QuizBizQuestions",
        "arn:aws:dynamodb:*:*:table/QuizBizQuestions/*"
       ]
    }
  ]
}
EOT
}

resource "aws_iam_role" "dbaccess_account" {
  name               = var.dbaccess-name
  assume_role_policy = ddb-access-policy
}

resource "aws_iam_role" "cross_account_assume_role" {
  name               = var.logging-name
  assume_role_policy = data.aws_iam_policy_document.cross_account_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "cross_account_assume_role" {
  count = length(var.policy_arns)

  role       = aws_iam_role.cross_account_assume_role.name
  policy_arn = element(var.policy_arns, count.index)
}

