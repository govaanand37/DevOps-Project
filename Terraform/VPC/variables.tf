variable "cidr" {
    default = "10.0.0.0/16" 
}

variable "subnet1-cidr" {
    default = "10.0.0.0/24"
  
}
variable "subnet2-cidr" {
    default = "10.0.1.0/24"
  
}
variable "availability_zone1" {
    default =  "us-east-1a"
  
}
variable "availability_zone2" {
    default =  "us-east-1b"
  
}