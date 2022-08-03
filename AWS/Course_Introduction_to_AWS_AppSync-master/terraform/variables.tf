variable "logging-name" {
  default     = "GuruQuizbizLogging"
  type        = string
  description = "The name of the role."
}
variable "dbaccess-name" {
  default     = "GuruQuizbizDataAccess"
  type        = string
  description = "The name of the role."
}
variable "principal_arns" {
  default     = ["appsync.amazonaws.com"]
  type        = list(string)
  description = "ARNs of accounts, groups, or users with the ability to assume this role."
}
variable "policy_arns" {
  default     = ["arn:aws:iam::aws:policy/service-role/AWSAppSyncPushToCloudWatchLogs"]
  type        = list(string)
  description = "List of ARNs of policies to be associated with the created IAM role."
}

