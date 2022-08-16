resource "aws_appsync_graphql_api" "appsync_api" {
  name                = "Simple Quiz API"
  authentication_type = "API_KEY"
  #  schema              = file("schema.graphql")
  schema = <<EOF
type Question {
  id: ID!
  text: String!
  explanation: String
  answers: [AWSJSON]
}

type Query {
  getQuestion(id: ID!): Question
}

input CreateQuestionInput {
  text: String!
  explanation: String
  answers: [AWSJSON]
}

type Mutation {
  createQuestion(input: CreateQuestionInput!): Question
}
EOF

  log_config {
    cloudwatch_logs_role_arn = var.logging_iam_role_arn
    field_log_level          = "ALL"
  }
}

