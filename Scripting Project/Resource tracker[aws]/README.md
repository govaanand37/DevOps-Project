# Script to report the resource usage in AWS 
## Along with CRON Job automation for the script

This is a simple shell script that will help us to fetch resources from AWS Account. Using this script in our organization, we can track our resource usage so that we can limit unwanted resources to avoid bills. However, there will be a few prerequisites, which I have listed below.

**<mark>Note: I'm doing the entire process on an Ubuntu machine, so based on your Operating system steps may vary</mark>**

### Pre-Requisites:

* AWS CLI
    
* Access key
    

## Installation of prerequisites:

### AWS CLI:

So on Ubuntu, I used a simple command where my package manager\[apt\] took care of everything the command is

```bash
sudo apt install awscli
```

Here is the link where you can refer to install AWS CLI based on your operating system [Install AWS CLI for your OS](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

### Create and configure access key:

To access our AWS account resources we should have an access key in our local machine to communicate and authenticate into our AWS account for that firstly we have to create the access key in our AWS account

**Step 1:**

Login into your AWS account and click on your AWS account name which will be located in the right corner

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1677074786770/f7d85e88-4133-4aca-a9fd-bf62f7893296.png align="center")

and select the security credentials once the security page is loaded, scroll and find the access key then click create access key it will prompt you with some warning read that and click Create

then it will create an access key ID and secret, copy that and put them in a safe place

**Step 2:**

Now let's configure that access key in our local machine

open the terminal and type

```plaintext
aws configure
```

once you run the above command, it will prompt you to enter the access key ID and secret paste them that's it also adds the default region name if required

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1677075313669/bd70b2b6-827b-4652-af78-630f4b183bd3.png align="center")

Now scripting part.....

# Script:

```bash
#!/bin/bash
###########################################################################
#This script is used to track the resource that we have in our aws account#
###########################################################################

##### List IAM Users #####
echo "IAM users are:" > resources.txt

echo "Before JSON Parsing" >> resources.txt
aws iam list-users >> resources.txt

echo "After JSON Parsing by filtering with username alone" >> resources.txt
aws iam list-users | jq '.Users[].UserName' >> resources.txt

##### List Ec2 Instances #####
echo "EC2 Instances that we have:" >> resources.txt
aws ec2 describe-instances | jq '.Reservations[].Instances[].Tags[].Value' >> resources.txt

##### list IAM Group #####
echo "IAM Groups are:" >> resources.txt

aws iam list-groups >> resources.txt

##### List S3 Bucket #####
echo "S3 buckets are:" >> resources.txt
aws s3 ls >> resources.txt
```

so this script will fetch the ec2 instance, s3 bucket, IAM user and IAM groups

to fetch those details, we should know all the resource commands.

That we can refer to the **link: AWS** [CLI Command Reference](https://docs.aws.amazon.com/cli/latest/index.html)

### The explanation for IAM User Commands:\[Same applies to remaining commands\]

```bash
##### List IAM Users #####
echo "IAM users are:" > resources.txt

echo "Before JSON Parsing" 
aws iam list-users >> resources.txt

echo "After JSON Parsing by filtering with username alone" >> resources.txt
aws iam list-users | jq '.Users[].UserName' >> resources.txt
```

Initially, I added a print command that will print IAM users and

I voluntarily appended that print statement in the resources.txt file <mark>[It's optional if you want you can or else remove &gt;&gt; resources.txt]</mark>

We can see all the data in the resources.txt file, which will get created automatically after the script completes its run.

```bash
aws iam list-users
```

* So the above command is used to list the IAM users, but it will print the IAM user along with all the metadata of the user
    
* ```bash
            "Users": [
                    {
                        "Path": "/",
                        "UserName": "Admin",
                        "UserId": "AIDAUNJYNNMM3S4XSNXCS",
                        "Arn": "arn:aws:iam::303450385177:user/Admin",
                        "CreateDate": "2022-10-30T13:59:35Z",
                        "PasswordLastUsed": "2023-02-22T14:19:41Z"
                    },
    ```
    
* To get particular metadata from the details, I used JSON parse to filter out the particular detail
    
    ```bash
    aws iam list-users | jq '.Users[].UserName' >> resources.txt
    ```
    
* The above command is used to parse the particular value from the JSON
    

### To use the script:

create a .sh file in your machine using

```bash
touch aws_resource_tracker.sh
chmod +x aws_resource_tracker
```

and give the execute permission to that script file, open the script file using the vim editor

```bash
vim aws_resource_tracker.sh
```

paste the script I provided and save it

now execute the script using

```bash
./aws_resource_tracker.sh
```

the output that we get in the resources.txt file is

```plaintext

IAM users are:
Before JSON Parsing
{
    "Users": [
        {
            "Path": "/",
            "UserName": "Admin",
            "UserId": "AIDAUNJYNNMM3S4XSNXCS",
            "Arn": "arn:aws:iam::303450385177:user/Admin",
            "CreateDate": "2022-10-30T13:59:35Z",
            "PasswordLastUsed": "2023-02-22T14:19:41Z"
        },
        {
            "Path": "/",
            "UserName": "Ironman",
            "UserId": "AIDAUNJYNNMMRP74QLMUT",
            "Arn": "arn:aws:iam::303450385177:user/Ironman",
            "CreateDate": "2023-02-22T14:21:40Z"
        },
        {
            "Path": "/",
            "UserName": "Spiderman",
            "UserId": "AIDAUNJYNNMMQRVXCPJSQ",
            "Arn": "arn:aws:iam::303450385177:user/Spiderman",
            "CreateDate": "2023-02-22T14:21:57Z"
        }
    ]
}
After JSON Parsing by filtering with username alone
"Admin"
"Ironman"
"Spiderman"

EC2 Instances that we have:
"MyUbuntu_server"

IAM Groups are:
{
    "Groups": [
        {
            "Path": "/",
            "GroupName": "Demo-Group",
            "GroupId": "AGPAUNJYNNMMWFAFO2N7H",
            "Arn": "arn:aws:iam::303450385177:group/Demo-Group",
            "CreateDate": "2022-10-30T14:17:06Z"
        }
    ]
}

S3 buckets are:
2022-11-19 18:51:41 elasticbeanstalk-ap-northeast-1-303450385177
```

## Automate Using CRON JOB:

To improvise this script, we can schedule this script to run at a particular time daily using CRON Job

Run `sudo nano /etc/crontab`

this will open the crontab file that we have in the etc/ directory

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1677083451463/2112aa3e-94a2-4f7a-8d9f-20046a3588ab.png align="center")

Let me add the job now to run this shell scripting file daily at 16:40\[4:40 pm\]

`40 16 * * * ubuntu bash /home/ubuntu/aws_resource_tracker.sh`

after adding the above line in the crontab file, then save and exit

now it will run that script automatically daily at 4:40 pm

Follow me for more content like this...