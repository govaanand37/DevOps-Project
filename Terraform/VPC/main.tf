resource "aws_vpc" "myfrstvpc" {
    cidr_block = var.cidr
    tags = { Name = "myfrstvpc" }
}

resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.myfrstvpc.id
    cidr_block = var.subnet1-cidr
    availability_zone = var.availability_zone1
    map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet2" {
    vpc_id = aws_vpc.myfrstvpc.id
    cidr_block = var.subnet2-cidr
    availability_zone = var.availability_zone2
    map_public_ip_on_launch = true 
}
#Attaching IGW to VPC so that traffic will flow inside VPC\
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myfrstvpc.id    
}
#Creating Route table which will helps us to route the traffic coming from internet to igw
resource "aws_route_table" "router" {
    vpc_id = aws_vpc.myfrstvpc.id
    route {
        cidr_block = "0.0.0.0/0" #This will route all the traffic coming from internet to igw
        gateway_id = aws_internet_gateway.igw.id
    }
    
}
#Now associating the created subnet to route table so route table will route the traffic to our created subnet
resource "aws_route_table_association" "rta1" {
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.router.id
}

resource "aws_route_table_association" "rta2" {
    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.router.id
}

resource "aws_security_group" "sg" {
    name = "My-sg" #This is the name of the security group
    description = "Allowing all the traffic from internet to our VPC"
    vpc_id = aws_vpc.myfrstvpc.id

    #Adding inbound rule
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    #Adding inbound rule
    ingress { #This will allow all the traffic from internet to our VPC
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    #Adding outbound rule
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {name= "My-sg"}
}

#Creating S3 bucket
resource "aws_s3_bucket" "s3bucket" {
  bucket = "vpc-bucket-s3"
}


#creating ec2 

resource "aws_instance" "server1" {
    ami = "ami-0c7217cdde317cfec"
    instance_type = t2.micro
    vpc_security_group_ids = [aws_security_group.sg.id]
      
}