#!/bin/bash

# clear output
clear

# defined colours
yellow='\033[1;33m'
green='\033[0;32m'
red='\033[0;31m'

#################################################################
########################### CONFIG ##############################
mysql_u="" # MySQL Username
mysql_p="" # MySQL Password
mysql_d="" # MySQL Database Name

s3_bucket=""
s3_dir="" # AWS 3S dir including bucket name e.g: "s3://your-bucket/your/directory"

tmp_dir="" # The directory to store the dump before uploading to S3
##################################################################


timestamp=`date +%s`

tmp_path="${tmp_dir}/${timestamp}.sql"
s3_path="${s3_bucket}/${s3_dir}/${timestamp}.sql"

echo -e "${yellow}Dumping ${mysql_d} to ${tmp_path}"

# reset colours
tput sgr0

# Dump the database
mysqldump -u $mysql_u -p$mysql_p $mysql_d > $tmp_path

# Check the file was uploaded
file_count=`ls ${tmp_path} | wc -l`

if [ $file_count -gt 0 ]
then
	echo -e "${green}MySQL dump complete"

	# reset colours
	tput sgr0
else
	echo -e "${red}MySQL dump failed"

	# reset colours
	tput sgr0

	exit
fi

# Check AWS CLS is installed
if ! type aws > /dev/null
then
  	echo -e "${red}aws is not installed"
  	echo -e "${red}You can install it using:"
  	echo -e "${red}pip install awscli"

	# reset colours
	tput sgr0

	exit
fi


# Check the bucket exists
count=`aws s3 ls ${s3_bucket} | wc -l`

if [ $count -lt 1 ]
then
	echo -e "${red}S3 bucket '${s3_bucket} does not exist'"

	# reset colours
	tput sgr0

	exit
fi

echo -e "${yellow}Copying dump to S3"

# reset colours
tput sgr0

# Copy the file to S3
aws s3 cp $tmp_path $s3_path

# Check the file was uploaded
file_count=`aws s3 ls ${s3_path} | wc -l`

if [ $file_count -gt 0 ]
then
	echo -e "${green}Copy to S3 successful"

	# reset colours
	tput sgr0
else
	echo -e "${red}Copy to S3 failed"

	# reset colours
	tput sgr0

	exit
fi

# reset colours
tput sgr0