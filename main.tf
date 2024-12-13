provider "aws" {
  region = "us-east-1"
}

# Crear la tabla DynamoDB
resource "aws_dynamodb_table" "terraform_lock_table" {
  name           = "terraform-lock-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

# Crear la instancia EC2 que depende de DynamoDB
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Reemplaza con tu ID de AMI
  instance_type = "t2.micro"
  tags = {
    Name = "MyInstance"
  }

  # Asegurarse de que la EC2 se cree después de la tabla DynamoDB
  depends_on = [aws_dynamodb_table.terraform_lock_table]
}
