//create database
//useage: run these scripts in terminal


//table: user_info
aws dynamodb create-table --table-name user_info --attribute-definitions AttributeName=user_id,AttributeType=S --key-schema AttributeName=user_id,KeyType=HASH  --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1

//table: course_sfu
aws dynamodb create-table --table-name course_sfu --attribute-definitions AttributeName=course_nbr,AttributeType=S AttributeName=course_section,AttributeType=S --key-schema AttributeName=course_nbr,KeyType=HASH AttributeName=course_section,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1

var tableName = 'course_sfu';
  putItem = function(course_nbr, course_section, days, description, end_time, instructor, meeting_dates, room, start_time, title) {
     var item = {
      "course_nbr": {
        "S": 'math150'
      },
      "course_section": {
        "S": 'D100-LEC (1623)'
      },
      "days": {
        "S": 'MoTuWeFr'
      },
      "description": {
        "S": 'Designed for students specializing in mathematics, physics, chemistry, computing science and engineering. Topics as for Math 151 with a more extensive review of functions, their properties and their graphs. Recommended for students with no previous knowledge of Calculus. '
      },
      "end_time": {
        "S": '9:20'
      },
      "instructor": {
        "S": 'Jeremy Chiu'
      },
      "meeting_dates": {
        "S": '2015/09/08 - 2015/12/07'
      },
      "room": {
        "S": 'B9201'
      },
      "start_time": {
        "S": '8:30'
      },
      "title": {
        "S": 'Calculus I with Review'
      }
    };
      
      dd.putItem({
         'TableName': tableName,
         'Item': item
      }, function(err, data) {
         err && console.log(err);
      });
   };
// Use the function we just created...
putItem('math150','D100-LEC (1623)', 'MoTuWeFr','Designed for students specializing in mathematics, physics, chemistry, computing science and engineering. Topics as for Math 151 with a more extensive review of functions, their properties and their graphs. Recommended for students with no previous knowledge of Calculus. ','9:20','Jeremy Chiu', '2015/09/08 - 2015/12/07', 'B9201', '8:30', 'Calculus I with Review');

aws dynamodb put-item --table-name course_sfu --item {"course_nbr": {"S": 'math150'},"course_section": {"S": 'D100-LEC (1623)'},"days": {"S": 'MoTuWeFr'},"description": {"S": 'Designed for students specializing in mathematics, physics, chemistry, computing science and engineering. Topics as for Math 151 with a more extensive review of functions, their properties and their graphs. Recommended for students with no previous knowledge of Calculus.'},"end_time": {"S": '9:20'},"instructor": {"S": 'Jeremy Chiu'},"meeting_dates": {"S": '2015/09/08 - 2015/12/07'},"room": {"S": 'B9201'},"start_time": {"S": '8:30'},"title": {"S": 'Calculus I with Review'}} --return-consumed-capacity TOTAL