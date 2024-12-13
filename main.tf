terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.72.1"
    }
  }

  required_version = ">= 0.14.9"
}


resource "aws_instance" "app_server" {
  ami           = "ami-0453ec754f44f9a4a"
  instance_type = "t3.micro"
  subnet_id     = "subnet-0167d706fb101e2ae"

  tags = {
    Name = var.instance_name
  }
}

resource "aws_dynamodb_table" "terraform_lock_table" {
  name           = "terraform-lock-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}