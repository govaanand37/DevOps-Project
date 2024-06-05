# Creating VPC
resource "aws_vpc" "myfrstvpc" {
  cidr_block = var.cidr
  tags       = { Name = "myfrstvpc" }
}

#Creating 2 Subnets under the vpc created and adding AZ
#Starts
resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.myfrstvpc.id
  cidr_block              = var.subnet1-cidr
  availability_zone       = var.availability_zone1
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.myfrstvpc.id
  cidr_block              = var.subnet2-cidr
  availability_zone       = var.availability_zone2
  map_public_ip_on_launch = true
}
#Ends

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

# Association for Subnet 1
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.router.id
}

# Association for Subnet 2
resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.router.id
}

# Creating a Security Group with rules to allow inbound and outbound traffic
resource "aws_security_group" "sg" {
  name        = "My-sg" #This is the name of the security group
  description = "Allowing all the traffic from internet to our VPC"
  vpc_id      = aws_vpc.myfrstvpc.id

  # Inbound rule to allow HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Inbound rule to allow SSH traffic
  ingress {

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Outbound rule to allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { name = "My-sg" }
}

# Creating an S3 bucket
resource "aws_s3_bucket" "s3bucket" {
  bucket = "vpc-bucket-s3"
}


# Creating two EC2 instances and attaching them to the security group and subnets

# EC2 Instance 1
resource "aws_instance" "server1" {
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = aws_subnet.subnet1.id
  user_data              = base64encode(file("userdata-1.sh"))
  tags                   = { Name = "Web-server-1" }

}
# EC2 Instance 2
resource "aws_instance" "server2" {
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = aws_subnet.subnet2.id
  user_data              = base64encode(file("userdata-2.sh"))
  tags                   = { Name = "Web-server-2" }
}


# Creating a Load Balancer to distribute traffic between the two EC2 instances

resource "aws_lb" "mylb" {
  name               = "mylb"
  internal           = false
  load_balancer_type = "application"
  #associating the subnets and sg to created ALB
  security_groups = [aws_security_group.sg.id]
  subnets         = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  tags = { Name = "mylb" }
}
# Creating a Target Group for the Load Balancer

resource "aws_lb_target_group" "tg" {
  name     = "tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myfrstvpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}
# Attaching the EC2 instances to the Target Group

# Attachment for EC2 Instance 1
resource "aws_lb_target_group_attachment" "attach-1" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.server1.id
  port             = 80
}

# Attachment for EC2 Instance 2
resource "aws_lb_target_group_attachment" "attach-2" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.server2.id
  port             = 80
}
# Creating a Listener for the Load Balancer to forward traffic to the Target Group
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.mylb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type             = "forward"
  }

}
# Outputting the DNS name of the Load Balancer
output "lb-dns-name" {
  value = aws_lb.mylb.dns_name

}