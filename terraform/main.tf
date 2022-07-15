#############################
# API Gateway
#############################

resource "aws_api_gateway_rest_api" "example_rest_api" {
  name = "example"
}

resource "aws_api_gateway_resource" "example_gateway_resource" {
  parent_id   = aws_api_gateway_rest_api.example_rest_api.root_resource_id
  path_part   = "pies"
  rest_api_id = aws_api_gateway_rest_api.example_rest_api.id
}

resource "aws_api_gateway_method" "example_gateway_method" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.example_gateway_resource.id
  rest_api_id   = aws_api_gateway_rest_api.example_rest_api.id
}

resource "aws_api_gateway_integration" "example_integration" {
  http_method = aws_api_gateway_method.example_gateway_method.http_method
  resource_id = aws_api_gateway_resource.example_gateway_resource.id
  rest_api_id = aws_api_gateway_rest_api.example_rest_api.id
  type        = "MOCK"
}

#############################
# Lambda
#############################

resource "aws_lambda_function" "db_access" {
  function_name = "dbAccess"
  filename = "./lambda_code/Archive.zip"
  layers = []
  handler = "handler.handler"
  runtime = "nodejs14.x"
  timeout = "300"
  memory_size = 1024
  role = "myrolesARN"
}

#############################
# DynamoDB
#############################
resource "aws_dynamodb_table" "main-table" {
  name           = var.table-name
  billing_mode   = "PROVISIONED"
  read_capacity  = 2
  write_capacity = 2
  hash_key       = "id"


  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name        = "${var.table-name}-${var.environment}"
    Environment = var.environment
  }
}

resource "null_resource" "init-db" {

   triggers = {
     new = aws_dynamodb_table.main-table.id
   }
   provisioner "local-exec" {
     command = <<EOT
       aws dynamodb batch-write-item --request-items file://formatted-data.json --endpoint-url ${var.dynamodb-addr}
     EOT
   }
   depends_on = [aws_dynamodb_table.main-table]
 }

output "main-table-id" {
  value = aws_dynamodb_table.main-table.id
}

output "main-table-arn" {
  value = aws_dynamodb_table.main-table.arn
}

output "main-table-stream-arn" {
  value = aws_dynamodb_table.main-table.stream_arn
}