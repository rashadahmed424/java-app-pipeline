terraform {
  backend "s3" {
    bucket = "petclinic-backend"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "petclinic-terraform"

  }
}
