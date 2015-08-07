/*
save the user_info table.
*/
console.log('Loading event');
var doc = require('dynamodb-doc');
var dynamodb = new doc.DynamoDB();

exports.handler = function(event, context) {
    dynamodb.listTables(function(err, data) {
    console.log("error is: " + err);
    console.log(JSON.stringify(data, null, '  '));
    });
    var tableName = "user_info";
    
    var params = {
        Item: {
            "user_id":event.user_id,
            "password":event.password
        },
        TableName: tableName
    }
    dynamodb.putItem(params,
     function(err, data) {
        if (err) {
            console.log("put item err." + err);
            context.done('error','putting item into dynamodb failed: '+err);
        }
        else {
            console.log('great success: '+JSON.stringify(data, null, '  '));
            context.succeed('created user ' + event.user_id + ' successfully.');
        }
    });
};