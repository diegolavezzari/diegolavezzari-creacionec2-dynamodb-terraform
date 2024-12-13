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
resource "aws_instance" "app_server" {
  ami           = "ami-0453ec754f44f9a4a"  # Reemplaza con tu ID de AMI
  instance_type = "t3.micro"
  subnet_id     = "subnet-0167d706fb101e2ae"
  tags = {
    Name = "ec2-dynamodb"
  }

  # Asegurarse de que la EC2 se cree después de la tabla DynamoDB
  depends_on = [aws_dynamodb_table.terraform_lock_table]
}
