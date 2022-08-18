resource "aws_dynamodb_table" "dynamodb_table" {
  name           = var.table_name
  hash_key       = var.partition_key
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = var.partition_key
    type = var.partition_type
  }
}

