terraform {
  backend "s3" {
    bucket = "petclinic-backend"
    key    = "terraform.tfstate"
    region = var.region
    dynamodb_table = "petclinic-terraform"

  }
}
