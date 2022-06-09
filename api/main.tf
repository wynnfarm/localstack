

resource "aws_api_gateway_rest_api" "rest_api" {
  name        = "rest_api"
  description = "This is my API for demonstration purposes"
}

resource "aws_api_gateway_resource" "api" {
  name = "api-gateway"
  description = "Proxy to handle requests to our API"
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = "mydemoresource"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method.http_method
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "http://your.domain.com/{proxy}"
 
  request_parameters =  {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}

