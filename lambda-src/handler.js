'use strict';

Object.defineProperty(exports, '__esModule', {
  value: true,
});
exports.handler = handler;

//  TODO: Need to test with MOA, Pending Future Agent, Active Agent, Inactive Agent
async function handler(event) {
  console.log('Event:', event);
  return 'Success!';
}
