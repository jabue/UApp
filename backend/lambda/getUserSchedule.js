/*
get schedule list for user.
author: rafy
date: 2015-10-2
*/

var doc = require('dynamodb-doc');
var db = new doc.DynamoDB();

exports.handler = function(event, context) {
    
    console.log("school is: " + event.school);
    
    var table_name = ''; 
    
    if (event.school == "University of British Columbia(UBC)") {
        pa = "user_course_ubc";
    }else if (event.school == "Simon Fraser University(SFU)"){
        pa = "user_course_sfu";
    }
    
    console.log("to query table: " + pa);
    
    var params = {
           
        TableName : pa,
        ProjectionExpression:"course_nbr, course_section,days,description,end_time,instructor,meeting_dates,room,start_time,title",
        KeyConditionExpression: "#nbr = :course_nbr",
        ExpressionAttributeNames:{
        "#nbr": "user_id"
        },
        ExpressionAttributeValues: {
            ":user_id":event.user_id
        }
   };
    
    db.getItem({
        params
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
