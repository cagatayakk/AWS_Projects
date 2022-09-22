#We should update yum package , remove AWS CLI v1 and install AWS CLI v2
sudo yum update -y
sudo yum remove aws-cli -y
aws --version
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip   #install "unzip" if not installed
sudo ./aws/install
aws --version

#Write your credentials using this command
aws configure

#Create Security Group
aws ec2 create-security-group \
    --group-name roman_numbers_sec_grp \
    --description "This Sec Group is to allow ssh and http from anywhere"
    
#We can check the security Group with these commands 
aws ec2 describe-security-groups --group-names roman_numbers_sec_grp

#Create Rules of security Group
aws ec2 authorize-security-group-ingress \
    --group-name roman_numbers_sec_grp \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
    --group-name roman_numbers_sec_grp \
    --protocol tcp \
    --port 80 \
    --cidr 0.0.0.0/0
 
#After creating security Groups, We'll create our EC2 which has latest AMI id. to do this, we need to find out latest AMI with AWS system manager (ssm) command
#This command is to get description of latest AMI ID that we use.
aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --region us-east-1

#This command is to run querry to get latest AMI ID
aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --query 'Parameters[0].[Value]' --output text

#we'll assign this latest AMI id to the LATEST_AMI environmental variable
LATEST_AMI=$(aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --query 'Parameters[0].[Value]' --output text)

#Now we can run the instance with CLI command. (Do not forget to create userdata.sh under "/home/ec2-user/" folder before run this command)
aws ec2 run-instances \
    --image-id $LATEST_AMI \
    --count 1 \
    --instance-type t2.micro \
    --key-name First_Key \
    --security-groups roman_numbers_sec_grp \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=roman_numbers}]' \
    --user-data file:///home/ec2-user/userdata.sh

#To see the each instances Ip we'll use describe instance CLI command
aws ec2 describe-instances --filters "Name=tag:Name,Values=roman_numbers"

#You can run the query to find Public IP and instance_id of instances
aws ec2 describe-instances --filters "Name=tag:Name,Values=roman_numbers" --query 'Reservations[].Instances[].PublicIpAddress[]'

#To delete instances
INSTANCE_ID=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=roman_numbers" --query 'Reservations[].Instances[].InstanceId[]' --output text)

aws ec2 terminate-instances --instance-ids $INSTANCE_ID


#To delete security groups
aws ec2 delete-security-group --group-name roman_numbers_sec_grp
