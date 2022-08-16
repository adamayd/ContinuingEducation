data "aws_iam_policy_document" "cross_account_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = var.principal_arns
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "db_access_policy_document" {
  statement {
    actions = [
      "dynamodb:batchgetitem",
      "dynamodb:batchwriteitem",
      "dynamodb:putitem",
      "dynamodb:deleteitem",
      "dynamodb:getitem",
      "dynamodb:scan",
      "dynamodb:query",
      "dynamodb:updateitem"
    ]

    resources = [
      "arn:aws:dynamodb:*:*:table/QuizBizQuestions",
      "arn:aws:dynamodb:*:*:table/QuizBizQuestions/*"
    ]

    effect = "Allow"
    sid    = "QuizBizQuestionTable"
  }
}

resource "aws_iam_policy" "db_access_policy" {
  name        = var.dbaccess-policy-name
  description = "DynamoDB access to Quiz Biz Questions"
  policy      = data.aws_iam_policy_document.db_access_policy_document.json
}

resource "aws_iam_role" "logging_account_role" {
  name               = var.logging-iam-role-name
  assume_role_policy = data.aws_iam_policy_document.cross_account_assume_role_policy.json
}

resource "aws_iam_role" "db_access_account_role" {
  name               = var.dbaccess-iam-role-name
  assume_role_policy = data.aws_iam_policy_document.cross_account_assume_role_policy.json
  #assume_role_policy = data.aws_iam_policy_document.db_access_policy_document.json
}

resource "aws_iam_role_policy_attachment" "logging_role_attachment" {
  role       = aws_iam_role.logging_account_role.name
  policy_arn = var.logging_arn
}

resource "aws_iam_role_policy_attachment" "db_access_role_attachment" {
  role       = aws_iam_role.db_access_account_role.name
  policy_arn = aws_iam_policy.db_access_policy.arn
}

