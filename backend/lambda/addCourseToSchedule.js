/*
save a course to user's schedule.
author: rafy
date: 2015-9-29
*/

var doc = require('dynamodb-doc');
var db = new doc.DynamoDB();

exports.handler = function(event, context) {
    console.log("user_id is: " + event.user_id);
    console.log("school is: " + event.school);
    
    var table = ''; 
    var title = null;
    var course_section = null;
    var days = null;
    var description = null;
    var end_time = null;
    var instructor = null;
    var room = null;
    var start_time = null;
    var meeting_dates = null;
    
    if (event.school == "University of British Columbia(UBC)") {
        table = "user_course_ubc";
    } 
    else if (event.school == "Simon Fraser University(SFU)"){
        table = "user_course_sfu";
    }
    if (event.course_section.length !== 0){
        course_section = event.course_section;
    }
    if (event.title.length !== 0){
        title = event.title;
    }
    if (event.days.length !== 0){
        days = event.days;
    }
    if (event.description.length !== 0){
        description = event.description;
    }
    if (event.end_time.length !== 0){
        end_time = event.end_time;
    }
    if (event.instructor.length !== 0){
        instructor = event.instructor;
    }
    if (event.room.length !== 0){
        room = event.room;
    }
    if (event.start_time.length !== 0){
        start_time = event.start_time;
    }
    if (event.meeting_dates.length !== 0){
        meeting_dates = event.meeting_dates;
    }
    var saveParams = {Item: {
        "user_id":event.user_id,                    
        "course_nbr":event.course_nbr,
        "course_section":course_section,
        "title":title,
        "days":days,
        "description": description,
        "end_time": end_time,
        "instructor":instructor,
        "room":room,
        "start_time":start_time,
        "meeting_dates":meeting_dates
        }, TableName: table}
    console.log("params = " + JSON.stringify(saveParams, null, '  '));
    db.putItem(saveParams,
         function(err, data) {
            if (err) {
                console.log("put item err." + err);
                context.done('error','putting item into dynamodb failed: ' + err);
            }
            else {
                console.log('add course successfully: ' + JSON.stringify(data, null, '  '));
                context.succeed('save course successfully.');
            }
    });        
}