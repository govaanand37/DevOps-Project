variable "ami" {
    description = "value of ami"
  
}

variable "ec2" {
    description = "value of ec2-type"
    type = map(string)
    default = {
      "dev" = "t2.micro"
      "stage" = "t2.medium"
      "prod" = "t2.xlarge"
    }
}