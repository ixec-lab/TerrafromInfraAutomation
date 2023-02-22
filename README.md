# PRE-SETUP
    Creating a new user in IAM console and assign correct permissions.
    Generating private SSH keys associated with VMs for testing and provisioning.

# Full code explanation :
    1. Setting up a VPC with CIDR : 10.0.0.0/16.
        Creating a VPC (Virtual Private Cloud) to define our network peremeters and assiging to a network CIDR range (10.0.0.0/16).

    2. Setting up a 2 subnets public and private with CIDR 10.0.1.0/24 , 10.0.2.0/24.
        dividing our parent network to 2 parts Public subnet and Private one, saying that the 10.0.1.0/24 subnet is public, then it can reach the internet directly via internet gateway, in ohter hand the 10.0.2.0/24 subnet is private so it is not connected to the internet geteway but with a NAT gateway

    3. Setting 3 linux server instances : 1 acting like jump box and 2 local instances playing the application.
        just to demonstrate the architectures that can be used (local ssh access to configure the machines in case of internet unavailability) and to test if the 2 instances are well configured but this way is less secure due to exposing sensitive informations in public box. (more details in main.tf comments)
    4. Setting up a an internet gateway for public subnet.
        Necessary network element to communicate with out side, pubic subnets are directly connected with this gateway to be reachable from outside

    5. Setting up a NAT gateway for local instances that they can have internet access but not accessible from the outside.
        This is the healthy way to make local instances connect to internet for downloading pakages and needed files but unreachable from outside, this helps to add a security layer than jump box (Bastion Host).

    6. Setting up 2 routing tables and neccessary routes for routing packets.
        Configuring 2 route table, 1 for public subnet and 1 for private subnet with needed routing rules:
            - private_nat_gateway    : To route traffic to NAT GATEWAY
            - public_internet_gatway : To route traffic to INTERNET GATEWAY

    7. Setting up a Classical & Network load balancers:
        - Classical lb : just for tesing purposes, we can see that is a bad idea using Classical one due to instability when working with hiegh level applications like python.
        - Netwrok lb   : Best solution in this cas, improves stability and efficiency.
        - Health checks: let's be sure that target servers are up and ready to handle requests.
        
    8. Setting up security groups to improves security.
        Security groups helps to apply security layer to contol the traffic in/out from our targted nodes, in this case we have 2 security group
        - sg-private : This allow HTTP traffic comming from anywhere but we know this vm nodes are isolated in private subnet so anywhere mean local traffic from others subnets or load balancer, also this rule allow ssh connections uniquily from public subnet (10.0.1.0/24), we also specify more restrected ruls buy just allowing some host(s) to connect over ssh
        - sg-bastion : This allow ssh traffic from anywhere (outside) - all users with private key can access this instance since its exposed to internet.

# NOTES : 
    - app.py: hosted in github and downloaded in vm provisioning
    - install.sh: bash script to start app in vm nodes
    - MakeInfraFromShell: bash script to do the same job with pure AWS CLI