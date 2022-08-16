variable "logging-iam-role-name" {
  default     = "GuruQuizbizLogging"
  type        = string
  description = "The name of the role."
}
variable "dbaccess-iam-role-name" {
  default     = "GuruQuizbizDataAccess"
  type        = string
  description = "The name of the role."
}
variable "dbaccess-policy-name" {
  default     = "DdbAccess"
  type        = string
  description = "Access to Quiz Biz Questions in DynamoDB"
}
variable "principal_arns" {
  default     = ["appsync.amazonaws.com"]
  type        = list(string)
  description = "ARNs of accounts, groups, or users with the ability to assume this role."
}
variable "logging_arn" {
  default     = "arn:aws:iam::aws:policy/service-role/AWSAppSyncPushToCloudWatchLogs"
  type        = string
  description = "List of ARNs of policies to be associated with the created IAM role."
}

