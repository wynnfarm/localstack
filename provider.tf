provider "aws" {
  access_key                  = "mock_access_key"
  region                      = "us-east-1"
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    dynamodb       = "http://localhost:4566"
    lambda       = "http://localhost:4566"
    iam = "http://localhost:4566"
    

  }
    # endpoints {
    #       lambda = "http://127.0.0.1:50024"
    #       apigateway = "http://127.0.0.1:50024"
    #       cloudformation = "http://127.0.0.1:50024"
    #       cloudwatch = "http://127.0.0.1:50024"
    #       dynamodb = "http://127.0.0.1:50024"
    #       ec2 = "http://127.0.0.1:50024"
    #       iam = "http://127.0.0.1:50024"
    #       route53 = "http://127.0.0.1:50024"
    #       s3 = "http://127.0.0.1:50024"
    #       sts = "http://127.0.0.1:50024"
    #       secretsmanager = "http://127.0.0.1:50024"
    #       kms = "http://127.0.0.1:50024"
    #     }
}
