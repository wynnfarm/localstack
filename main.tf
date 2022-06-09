#############################
# DynamoDB
#############################
resource "aws_dynamodb_table" "main-table" {
  name           = var.table-name
  billing_mode   = "PROVISIONED"
  read_capacity  = 2
  write_capacity = 2
  hash_key       = "atmassociateId"


  attribute {
    name = "atmassociateId"
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
       aws dynamodb batch-write-item --request-items file://static/formatted-data.json --endpoint-url ${var.dynamodb-addr}
     EOT
   }
   depends_on = [aws_dynamodb_table.main-table]
 }

module "lambda" {
  source = "./lambda"
  path = "firstOne"
  function_name = "myLambda"
}



