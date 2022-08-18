output "logging_iam_role_arn" {
  value = aws_iam_role.logging_account_role.arn
}
output "db_access_iam_role_arn" {
  value = aws_iam_role.db_access_account_role.arn
}

