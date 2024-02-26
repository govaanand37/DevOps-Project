terraform {
  backend "s3" {
    bucket = "bucket-for-terraform-remote-backend"
    encrypt = true
    dynamodb_table = "terraform-lock"
  }
}