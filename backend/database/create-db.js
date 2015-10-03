//create database
//useage: run these scripts in terminal
//prerequiste: install aws cli


//table: user_info
aws dynamodb create-table --table-name user_info --attribute-definitions AttributeName=user_id,AttributeType=S --key-schema AttributeName=user_id,KeyType=HASH  --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1

//table: course_sfu
aws dynamodb create-table --table-name course_sfu --attribute-definitions AttributeName=course_nbr,AttributeType=S AttributeName=course_section,AttributeType=S --key-schema AttributeName=course_nbr,KeyType=HASH AttributeName=course_section,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1

//table:user_course_sfu
aws dynamodb create-table --table-name user_course_sfu --attribute-definitions AttributeName=user_id,AttributeType=S AttributeName=course_nbr,AttributeType=S --key-schema AttributeName=user_id,KeyType=HASH AttributeName=course_nbr,KeyType=RANGE --provisioned-throughput

aws dynamodb put-item --table-name course_sfu --item '{"course_nbr": {"S": "cmpt307"},"course_section": {"S": "D100-LEC (7418)"},"days": {"S": "TuTh"},"description": {"S": "Analysis and design of data structures for lists, sets, trees, dictionaries, and priority queues. A selection of topics chosen from sorting, memory management, graphs and graph algorithms. Prerequisite: CMPT 225, MACM 201, MATH 151 (or MATH 150), and MATH 232 or 240."},"end_time": {"S": "16:20|15:20"},"instructor": {"S": "Geoffrey Tien"},"meeting_dates": {"S": "2015/09/08 - 2015/12/07"},"room": {"S": "K9500|AQ3003"},"start_time": {"S": "14:30|14:30"},"title": {"S": "Data Structures and Algorithms"}}' --return-consumed-capacity TOTAL

				