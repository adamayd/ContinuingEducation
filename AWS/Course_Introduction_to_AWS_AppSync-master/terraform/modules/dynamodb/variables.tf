variable "table_name" {
  type        = string
  description = "DynamoDB table name"
}
variable "partition_key" {
  type        = string
  description = "Partition or primary key"
}
variable "partition_type" {
  type        = string
  description = "Partition key type S(string), N(number), or B(binary)"
}

