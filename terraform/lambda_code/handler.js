"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});

// var _uuid = require("uuid");

// var _clientDynamodb = require("@aws-sdk/client-dynamodb");

// var _libDynamodb = require("@aws-sdk/lib-dynamodb");

// const ddbClient = new _clientDynamodb.DynamoDBClient({
//     region: 'us-east-1',
//     endpoint: 'http://localhost:4566'
//   });
  
//   const ddbDocClient = _libDynamodb.DynamoDBDocumentClient.from(ddbClient);

exports.handler =  async (event) => {
    let log = []
  // create unique ID for new entries
//   item.id = _uuid.v4();
//   item.favoritePie = 'testPie'
//   log.push(`${event}`)
//   const params = {
//     TableName: 'my_first_localstack_table',
//     Item: item
//   };

//   try {
//     log.push('adding pie to db')
//     await ddbDocClient.send(new _libDynamodb.PutCommand(params));
//   } catch (error) {
//       log.push(`Error: ${error}`)
//       console.log(error)
//   }
  return event;
}


