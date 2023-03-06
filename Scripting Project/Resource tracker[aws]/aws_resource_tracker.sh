#!/bin/bash
#####################################################################################################################################
#This script is used to track the resource that we have in our aws account

# List IAM Users
echo "IAM users are:" >> resources.txt

echo "Before JSON Parsing" >> resources.txt
aws iam list-users >> resources.txt

echo "After JSON Parsing by filtering with username alone" >> resources.txt
aws iam list-users | jq '.Users[].UserName' >> resources.txt

# List Ec2 Instances
echo "EC2 Instances that we have:" > resources.txt

echo "Before JSON Parsing EC2 instance details" >> resources.txt
aws ec2 describe-instances >> resources.txt

echo "After Json parsing by filtering with keyname of ec2" >> resources.txt
aws ec2 describe-instances | jq '.Reservations[].Instances[].Tags[].Value' >> resources.txt



# list IAM Group
echo "IAM Groups are:" >> resources.txt

aws iam list-groups >> resources.txt

# List S3 Bucket
echo "S3 buckets are:" >> resources.txt
aws s3 ls >> resources.txt

#####################################################################################################################################


