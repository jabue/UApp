/*
get course list for user.
author: rafy
date: 2015-9-25
*/
console.log('Loading event');
var doc = require('dynamodb-doc');
var db = new doc.DynamoDB();

exports.handler = function(event, context) {
    
    console.log("school is: " + event.school);
    var table_name = ''; 
    if (event.school == "University of British Columbia(UBC)") {
        pa = "course_ubc";
    }else if (event.school == "Simon Fraser University(SFU)"){
        pa = "course_sfu"
    }
    console.log("to query table: " + pa)
        
    db.scan({
        TableName : pa,
        Limit : 50
    }, function(err, data) {
        if (err){
            console.log("get item err." + err);
            context.done('error','getting item from dynamodb failed: '+err);
        }else{
            for (var ii in data.Items) {
                ii = data.Items[ii];
                console.log(ii.course_nbr);
                console.log(ii.title);
            }
            console.log("get list successfully." + Object.keys(data).length);
            if(Object.keys(data).length !== 0)
                context.succeed(data);
            else
                context.succeed('NotFound');
        }
    });
};