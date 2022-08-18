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

module "simple_quiz_api_iam_roles" {
  source = "./modules/iam-roles"
}

module "quiz_biz_questions_dynamodb" {
  source         = "./modules/dynamodb"
  table_name     = "QuizBizQuestions"
  partition_key  = "id"
  partition_type = "S"
}

module "simple_quiz_appsync_api" {
  source                  = "./modules/appsync"
  name                    = "Simple Quiz API"
  schema_file             = "../schemas/simple-mutations.graphql"
  logging_iam_role_arn    = module.simple_quiz_api_iam_roles.logging_iam_role_arn
  datasource_name         = "DynamoQuestions"
  datasource_iam_role_arn = module.simple_quiz_api_iam_roles.db_access_iam_role_arn
  datasource_table_name   = module.quiz_biz_questions_dynamodb.table_name
}

