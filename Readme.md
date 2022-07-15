reference
[How to use AWS DynamoDB locally…](https://faun.pub/how-to-use-aws-dynamodb-locally-ad3bb6bd0163#92fe-53da0f183cd6)

## **Initial Setup**

- [Docker Install & Setup](https://techguide.opr.statefarm.org/index.php/Docker_-_Install_%26_Setup)

- NoSQL Workbench for Amazon DynamoDB

  - If on Mac, install through Self Service Portal
  - If on PC, install through ??

## **Using Localstack**

- ### Running LocalStack

      right click on docker-compose.yml and select "Compose up" or run:

      `docker compose -f docker-compose.yml up -d --build`

- ### Create DynamoDB

  Using the terraform files provided, run the following commands:

  ```
  terraform init && terraform plan -out="myplan"

  terraform apply -auto-approve myplan
  ```

  - Need to add an alias
    `alias awslocal="aws --endpoint-url=http://localhost:4566"`

  - Write Data (optional)

    `awslocal dynamodb batch-write-item --request-items file://static/formatted-data.json`

  - Validate Table/Data

    - Once the tables are created run the following commands to confirm the table exists and the data was built.

      ```
      awslocal dynamodb list-tables

      awslocal dynamodb scan --table-name sf_acms_asp_systemAccessRequest_table
      ```

### Clean up

- To destory the previously setup database run the following:

  `terraform destroy -auto-approve`

- Stopping Localstack

  - right click on docker-compose.yml and select "Compose down" or run:

    `docker compose -f docker-compose.yml down`
