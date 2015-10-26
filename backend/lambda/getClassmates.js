/*
get classmates list 
author: rafy
date: 2015-10-22

input: {"user_id": "usr@s.com", "school": "Simon Fraser University(SFU)", "course_nbr": "cmpt100"}

output: {
  "ConsumedCapacity": {
    "CapacityUnits": 0.5,
    "TableName": "user_course_sfu"
  },
  "Count": 2,
  "Items": [
    {
      "user_id": "usr2@s.com"
    },
    {
      "user_id": "usr1@s.com"
    }
  ],
  "ScannedCount": 7
}

logic:
1. find the table name according to the 'school', for there are different table to save the course data for different schools;
2. find the course_section from the table by the 'user_id' & 'course_nbr';
3. find the user_id list from the table by the 'course_nbr' & 'course_section';
4. return the user_id list in JSON.
*/

var doc = require('dynamodb-doc');
var db = new doc.DynamoDB();

exports.handler = function(event, context) {
    
    console.log("school is: " + event.school);
    var table_name = ''; 
    if (event.school == "University of British Columbia(UBC)") {
        pa = "user_course_ubc";
    }else if (event.school == "Simon Fraser University(SFU)"){
        pa = "user_course_sfu"
    }
    console.log("to query table: " + pa)
    
    var params = { 
        TableName: pa,
        Key: {
        "user_id": event.user_id,
        "course_nbr": event.course
        }
    };
    
    db.getItem(params, function(err, data) {
        if (err)
            console.log(JSON.stringify(err, null, 2));
        else {
            console.log(JSON.stringify(data, null, 2));
            var course_section = data.Item.course_section
            console.log("course_section = " + course_section + ", course_nbr = " + event.course)
            
            var params = { 
                "TableName": pa,
                "ProjectionExpression": "user_id",
                "FilterExpression": "course_nbr = :course AND course_section = :section",
                "ExpressionAttributeValues": {":course": event.course , ":section": course_section},
                "ReturnConsumedCapacity": "TOTAL"
            };
            
            db.scan(params, function(err, data1) {
                if (err){
                    console.log("query err." + err);
                    context.done('error','query from dynamodb failed: ' + err);
                }else{
                    for (var ii in data1.Items) {
                        ii = data1.Items[ii];
                        console.log(ii.user_id);
                    }
                console.log("get list successfully." + Object.keys(data1).length);
                    console.log(JSON.stringify(data1, null, 2));
                if(Object.keys(data1).length !== 0)
                    context.succeed(data1);
                else
                    context.succeed('NotFound');
                }
            });
        }
    });
};
