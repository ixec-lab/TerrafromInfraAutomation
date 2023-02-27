#!/bin/bash

VM_IMAGE_ID=ami-0f2649018fb0e2de2
AV_ZONE=us-east-1a

# Create VPC
vpc_id=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query 'Vpc.VpcId' --output text)
aws ec2 modify-vpc-attribute --vpc-id $vpc_id
aws ec2 modify-vpc-attribute --vpc-id $vpc_id

# Create public subnet
public_subnet_id=$(aws ec2 create-subnet --vpc-id $vpc_id --cidr-block 10.0.1.0/24 --availability-zone us-west-2a --query 'Subnet.SubnetId' --output text)

# Create private subnet
private_subnet_id=$(aws ec2 create-subnet --vpc-id $vpc_id --cidr-block 10.0.2.0/24 --availability-zone us-west-2a --query 'Subnet.SubnetId' --output text)

# Create Internet Gateway
internet_gateway_id=$(aws ec2 create-internet-gateway --query 'InternetGateway.InternetGatewayId' --output text)
aws ec2 attach-internet-gateway --internet-gateway-id $internet_gateway_id --vpc-id $vpc_id

# Create NAT Gateway
nat_eip=$(aws ec2 allocate-address --domain vpc --query 'AllocationId' --output text)
nat_gateway_id=$(aws ec2 create-nat-gateway --subnet-id $public_subnet_id --allocation-id $nat_eip --query 'NatGateway.NatGatewayId' --output text)

# Create public route table
public_route_table_id=$(aws ec2 create-route-table --vpc-id $vpc_id --query 'RouteTable.RouteTableId' --output text)
aws ec2 associate-route-table --route-table-id $public_route_table_id --subnet-id $public_subnet_id
aws ec2 create-route --route-table-id $public_route_table_id --destination-cidr-block 0.0.0.0/0 --gateway-id $internet_gateway_id

# Create private route table
private_route_table_id=$(aws ec2 create-route-table --vpc-id $vpc_id --query 'RouteTable.RouteTableId' --output text)
aws ec2 associate-route-table --route-table-id $private_route_table_id --subnet-id $private_subnet_id
aws ec2 create-route --route-table-id $private_route_table_id --destination-cidr-block 0.0.0.0/0 --nat-gateway-id $nat_gateway_id


# Create security groups
public_security_group_id=$(aws ec2 create-security-group --group-name public-security-group --description "Public security group" --vpc-id $vpc_id  --query 'GroupId' --output text)
aws ec2 authorize-security-group-ingress --group-id $public_security_group_id --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-egress --group-id $public_security_group_id --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $public_security_group_id --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-egress --group-id $public_security_group_id --protocol tcp --port 22 --cidr 0.0.0.0/0

# Create security groups
private_security_group_id=$(aws ec2 create-security-group --group-name private-security-group --description "Private security group" --vpc-id $vpc_id  --query 'GroupId' --output text)
aws ec2 authorize-security-group-ingress --group-id $private_security_group_id --protocol tcp --port 80 --cidr 0.0.0.0/0 
aws ec2 authorize-security-group-egress --group-id $private_security_group_id --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $private_security_group_id --protocol tcp --port 22 --cidr 10.0.1.0/24
aws ec2 authorize-security-group-egress --group-id $private_security_group_id --protocol tcp --port 22 --cidr 0.0.0.0/0

# Private instance (in private subnet)
aws ec2 run-instances --image-id $VM_IMAGE_ID --count 2 --instance-type t2.micro --key-name ssh.pem --security-group-ids $private_security_group_id --subnet-id $PRIVATE_SUBNET_ID --associate-public-ip-address false

# Public instance (in public subnet)
aws ec2 run-instances --image-id $VM_IMAGE_ID --instance-type t2.micro --key-name ssh.pem --security-group-ids $public_security_group_id --subnet-id $PUBLIC_SUBNET_ID

# Network load balancer
aws elbv2 create-load-balancer --name Nlb --subnets $public_subnet_id --scheme inernet-facing

# Target group 
target_group_id=$(aws elbv2 create-target-group --name nTaregtGroup --protocol TCP --port 80 --vpc-id $VPC_ID --query 'TargetGroup.TaregtGroupId' --output text)

arn=$(aws elbv2 register-targets --target-group-arn $target_group_id --targets Id=$privateInstanceId1 ,Id=$privateInstanceId1 --query )

aws elbv2 create-listener --load-balancer-arn $arn --protocol TCP --port 80 --default-actions Type=forward,TargetGroupArn=$arn



