Example: <https://levelup.gitconnected.com/aws-run-an-s3-triggered-lambda-locally-using-localstack-ac05f03dc896>
Reference: <https://gist.github.com/crypticmind/c75db15fd774fe8f53282c3ccbe3d7ad>

## Add 'awslocal' & env setup

```
alias awslocal="awslocal --endpoint-url=http://localhost:4566"' >> ~/.zshrc
API_NAME=isUserAuthorized
REGION=us-east-1
STAGE=test
```

Mac: 
`zip function.zip handler.js`

Windows:
`tar.exe -a -c -f output.zip myfile.txt`

```
awslocal lambda create-function --function-name my-lambda \
--zip-file fileb://function.zip \
--handler handler.handler --runtime nodejs12.x \
--role arn:aws:iam::000000000000:role/lambda-role
```

```
awslocal lambda create-function \
 --function-name isUserAuthorized \
 --zip-file fileb://function.zip \
 --handler handler.handler \
 --runtime nodejs12.x \
 --role arn:aws:iam::000000000000:role/lambda-role \
```

output logs of lambda

```
awslocal logs tail '/aws/lambda/isUserAuthorized' --follow
```

```
awslocal lambda invoke \
 --function-name isUserAuthorized \
 --invocation-type Event \
 --cli-binary-format raw-in-base64-out \
 --payload '{ "key": "value" }' response.json \
```

```
awslocal lambda update-function-code \
  --function-name isUserAuthorized \
  --zip-file fileb://function.zip \
```

### Setup API Gateway

```
awslocal apigateway create-rest-api \
  --region us-east-1 \
  --name isAuthorized \
```

```
API_ID=$(awslocal apigateway get-rest-apis \
  --query "items[?name==\`${API_NAME}\`].id" \
  --output text --region ${REGION})
echo $API_ID
```

```
awslocal lambda create-function \
  --region ${REGION} \
  --function-name ${API_NAME} \
  --runtime nodejs12.x \
  --handler handler.handler \
  --memory-size 128 \
  --zip-file fileb://function.zip \
  --role arn:aws:iam::123456:role/irrelevant \
```

```
awslocal lambda delete-function \
  --function-name ${API_NAME} \
```

```
awslocal lambda list-functions
```

```
LAMBDA_ARN=$(awslocal lambda list-functions \
  --query "Functions[?FunctionName==\`${API_NAME}\`].FunctionArn" \
  --output text --region ${REGION} \
  )
echo $LAMBDA_ARN
```

```
PARENT_RESOURCE_ID=$(awslocal apigateway get-resources \
  --rest-api-id ${API_ID}
  --query 'items[?path==`/`].id'
  --output text --region ${REGION})
```
