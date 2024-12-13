module "dynamodb_table" {
  source   = "terraform-aws-modules/dynamodb-table/aws"

  name     = "terraform-state-lock"
  hash_key = "LockID"

  attributes = [
    {
      name = "id"
      type = "S"
    }
  ]

  billing_mode = "PAY_PER_REQUEST"

  tags = {
    Terraform   = "true"
    Environment = "production"
  }
}
