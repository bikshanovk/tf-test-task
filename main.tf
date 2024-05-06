provider "aws" { 
  region = "us-east-2"
  alias = "parent"
}

provider "aws" {
  region     = var.region
  alias      = "prod"
  assume_role {
      role_arn = "arn:aws:iam::${var.prod_account_id}:role/OrganizationAccountAccessRole"
      }
}
provider "aws" {
  region     = var.region
  alias      = "dev"
  assume_role {
      role_arn = "arn:aws:iam::${var.dev_account_id}:role/OrganizationAccountAccessRole"
      }
}

  data "aws_caller_identity" "parent" {
    provider = aws.parent
}
  data "aws_caller_identity" "dev" {
    provider = aws.dev
}

  data "aws_caller_identity" "prod" {
    provider = aws.prod
}

module "s3_web_site_dev" {
source = "./modules/s3-multi-account"
    providers = {
      aws = aws.dev
  } 
  enviropment = "dev"
}

module "s3_web_site_prod" {
source = "./modules/s3-multi-account"
    providers = {
      aws = aws.prod
  } 
  enviropment = "prod"
}