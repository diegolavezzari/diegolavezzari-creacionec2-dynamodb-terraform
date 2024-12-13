terraform {
  backend "s3" {
    bucket         = "mundose2024"
    region         = "us-east-1"
    key            = "backend.tfstate"
    dynamodb_table = "terraform-state-lock"
  }
}
