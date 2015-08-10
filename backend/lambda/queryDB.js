/*
query the user_info table.
*/
console.log('Loading event');
var doc = require('aws-sdk');
var dynamodb = new doc.DynamoDB();

exports.handler = function(event, context) {
    
    var pa = { TableName: 'user_info'};
    dynamodb.describeTable(pa, function(err, data) {
        if (err) console.log(err, err.stack);
        else console.log(data);
    });
        
    var params = {
       Key: {
           user_id:{
               S: event.user_id
           }
       },
        TableName: 'user_info',
        ProjectionExpression: 'password'
    };
    
    dynamodb.getItem(params,
     function(err, data) {
        if (err) {
            console.log("get item err." + err);
            context.done('error','getting item from dynamodb failed: '+err);
        }
        else {
            console.log('great success: '+JSON.stringify(data, null, '  '));
            context.succeed('created user ' + event.user_id + ' successfully.');
        }
    });
};