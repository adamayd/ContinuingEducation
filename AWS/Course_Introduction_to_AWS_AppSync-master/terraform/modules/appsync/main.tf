resource "aws_appsync_graphql_api" "appsync_api" {
  name                = var.name
  authentication_type = "API_KEY"
  schema              = file(var.schema_file)

  log_config {
    cloudwatch_logs_role_arn = var.logging_iam_role_arn
    field_log_level          = "ALL"
  }
}

resource "aws_appsync_datasource" "appsync_datasource" {
  api_id           = aws_appsync_graphql_api.appsync_api.id
  name             = var.datasource_name
  service_role_arn = var.datasource_iam_role_arn
  type             = "AMAZON_DYNAMODB"

  dynamodb_config {
    table_name = var.datasource_table_name
  }
}

