
module "test-workspace" {
    source = "./modules/ec2"
    ami = var.ami
    ec2 = lookup(var.ec2,terraform.workspace,"t2.micro")
  
}