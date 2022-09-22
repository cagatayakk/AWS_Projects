#We should update yum package ,remove AWS CLI v1 and install AWS CLI v2
sudo yum update -y
sudo yum remove aws-cli -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
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
