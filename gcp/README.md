# PRE-SETUP
    Creaction of project id & generating credentials.json 
# Full code explanation
    1. Setting up a VPC with CIDR : 192.168.0.0 /16 (Auto generated in gcp).
    2. Setting up a 2 subnets public and private with CIDR 192.168.1.0/24 , 192.168.2.0/24.
        dividing our parent network to 2 parts Public subnet and Private one, saying that the 192.168.1.0/24 subnet is public, then it can reach the internet directly via internet gateway, in ohter hand the 192.168.2.0/24 subnet is private so it is connected to the NAT gateway to enable internet access and make it unreachble from outside.
    3. Setting 3 linux server instances : 1 acting like jump box and 2 local instances playing the application.
        just to demonstrate the architectures that can be used (local ssh access to configure the machines in case of internet unavailability) and to test if the 2 instances are well configured but this way is less secure due to exposing sensitive informations in public box.
    4. Setting up a NAT gateway for local instances that they can have internet access
        This is the healthy way to make local instances connect to internet for downloading pakages and needed files but unreachable from outside, this helps to add a security layer
    5. Setting up a NAT router to route packets from / to private subnet unlike AWS internet gateway is already configured.
    6. Setting up a network load balancer to balance the traffic and payloads between the 2 private instances (servers).
        - Creating a forwarding rule to target the pool.
        - Creating the pool which contain 2 previous private instances.
        - Configuring the health check to ensure that each servers works properly.
    7. Setting up Firewalls for security layer , allowing just useful services.
    8. Setting up montoring & alarms to control what is happening.