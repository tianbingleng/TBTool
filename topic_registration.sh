##############################    CONFIG    ##############################
WORKSPACE=/Users/tianbingleng/Documents/JavaWorkspace/kafka-streams-enrichment/src/main/scripts/schemaregistry
KAFKA_LIB_WORKSPACE=/Users/tianbingleng/Documents/JavaWorkspace/kafka-streams-lib/
AVRO_SCHEMA_DIR=/Users/tianbingleng/Documents/JavaWorkspace/kafka-streams-lib/src/main/resources/avroschemas/notifications


FILE_1=issueslineitem.avsc
TOPIC_1=issues_lineitem

FILE_2=issueslineitemtransform.avsc
TOPIC_2=issues_lineitem_transform

FILE_3=insuserlineitem.avsc
TOPIC_3=ins_user_lineitems

FILE_4=tokeninvalidadaccount.avsc
TOPIC_4=token_invalid_adaccount_notification

FILE_5=tokeninvaliduser.avsc
TOPIC_5=token_invalid_user_notification




AVRO_FILES=($FILE_1 $FILE_2 $FILE_3 $FILE_4 $FILE_5)
KAFKA_TOPICS=($TOPIC_1 $TOPIC_2 $TOPIC_3 $TOPIC_4 $TOPIC_5)


# get latest version of avro schema
cd $KAFKA_LIB_WORKSPACE
git checkout master
git pull

# copy all avro schema to workspace [only the notification type ones]
echo "copy files from $AVRO_SCHEMA_DIR to $WORKSPACE..."
cp $AVRO_SCHEMA_DIR/* $WORKSPACE/




## get length of $distro array
len=${#AVRO_FILES[@]}
 
## Use bash for loop 
cd $WORKSPACE
for (( i=0; i<$len; i++ )); do 
	export SCHEMA_REGISTRY_URL=http://localhost:8081
	export TOPIC_NAME=${KAFKA_TOPICS[$i]}
	export AVRO_SCHEMA_FILE=${AVRO_FILES[$i]}
	python register_schema.py 
done

