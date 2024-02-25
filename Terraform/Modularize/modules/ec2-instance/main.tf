resource "aws_instance" "newec2" {
    ami= var.ami
    instance_type = var.instance_type
    key_name = var.key_name
  
}