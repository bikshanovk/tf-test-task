
terraform {
  backend "s3" {
    bucket = "tf-state-yj7fx5"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-lock-example"
  }
}
