provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "terraform_state" {
  bucket        = var.aws_s3_bucket

  tags = {
    Name = "TerraformStateBucket"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "terraform_state_acl" {
  bucket = aws_s3_bucket.terraform_state.bucket
  acl    = "private"
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "TerraformStateLockTable"
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-0453ec754f44f9a4a"
  instance_type = "t3.micro"
  subnet_id     = "subnet-0167d706fb101e2ae"

  tags = {
    Name = var.ec2_dynamodb
  }

  depends_on = [aws_dynamodb_table.terraform_state_lock]
}