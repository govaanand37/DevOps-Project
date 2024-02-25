module "ec2-creation" {
    source = "./ec2-instance"
    ami = "ami-0c7217cdde317cfec"
    instance_type = "t2.micro"
    key_name = "terraform-test"
    region = us-east-1
}