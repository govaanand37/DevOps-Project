provider "aws"{
    region = "us-east-1"
}

resource "aws_instance" "first-ec2-using-terraform" {
    ami = "ami-0c7217cdde317cfec"
    instance_type = "t2.micro"
    key_name = "terraform-test"
    tags = {
    Name = "ec2-with-backend"
  }
}