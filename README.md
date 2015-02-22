# MySQL Backup Script for Amazon S3

A basic script for dumping a MySQL database and uploading the dump to Amazon S3.

First, if you haven't already, install AWS CLI. Help can be found here: http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html


Next set up the variables in the script as below:

Variable Name | Description | Example
------------ | ------------- |  -------------
mysql_u | Your MySQL Username | root
mysql_p | Your MySQLPassword | Pa55w0rd
mysql_d | Your MySQL Database Name | db_1
s3_bucket | Your AWS S3 Bucket Name | s3://your-bucket
s3_dir | The S3 directory you want to store your backups | backups
tmp_dir | The temporary directory to store the dump before uploading | /tmp

Set up a cron job for the script and your done.

Note: I would recommend using AWS Lifecycle Rules to delete old files. Details on how to do that can be found at: http://docs.aws.amazon.com/AmazonS3/latest/UG/LifecycleConfiguration.html
