variable "name" {
  type        = string
  description = "Name for AppSync API"
}
variable "schema_file" {
  type        = string
  description = "Schema file location from root module."
}
variable "logging_iam_role_arn" {
  type        = string
  description = "IAM Role for logging in cloudwatch."
}
variable "datasource_name" {
  type        = string
  description = "Datasource name"
}
variable "datasource_iam_role_arn" {
  type         = string
  description = "IAM Role for datasource."
}
variable "datasource_table_name" {
  type        = string
  description = "Dynamodb datasource table name."
}

