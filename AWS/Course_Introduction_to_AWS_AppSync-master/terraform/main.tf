provider "aws" {
  region = "us-east-2"
}

resource "aws_budgets_budget" "testing-only" {
  name              = "monthly-budget"
  budget_type       = "COST"
  limit_amount      = "20.00"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2022-04-01_00:01"
}

module "iam_roles" {
  source = "./modules/iam-roles"
}

module "appsync" {
  source               = "./modules/appsync"
  logging_iam_role_arn = module.iam_roles.logging_iam_role_arn
}

