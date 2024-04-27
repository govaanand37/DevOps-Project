resource "aws_instance" "example" {
    ami = var.ami
    instance_type = var.ec2
    tags = {
    Name = terraform.workspace
  }
  
}
