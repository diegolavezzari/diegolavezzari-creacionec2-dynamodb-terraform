terraform {
  backend "s3" {
    bucket         = var.aws_s3_bucket
    region         = var.region
    key            = "backend.tfstate"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
