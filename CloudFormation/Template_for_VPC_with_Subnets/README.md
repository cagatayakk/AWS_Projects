# Custom VPC Creation with Private and Public Subnet , Internet Gateway , NAT Gateway , Elastic IP , Endpoint to S3 and Peering Connections
![Architecture_of_Template](Overview.png)


## We will cretae : 
- 1 VPC
- 2 Public Subnet and 2 Private Subnet
- 1 Internet Gateway and attach it to VPC
- 1 Public Route table for all the public connectivity – all public traffic goes through internet gateway
- Associate both public subnet to public route table
- 1 elastic IPs that will be used by NAT gateway
- Create two private route table one for each private subnet
- 1 NAT Gateway or 1 NAT-Instance to provide internet connectivity to our private subnet
- Route private traffic of each subnet in route table via respective NAT gateway
- Associate private subnet to private route table
- We will have a fully function VPC with internet connection in private as well as public subnet
- Endpoint to S3 Services (with S3FullAccessPolicy) for all Subnets
- Peering Connection to other VPC (on the same Account and Region)
