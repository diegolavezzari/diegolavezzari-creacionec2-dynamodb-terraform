resource "aws_dynamodb_table" "terraform_lock_table" {
  name           = "terraform-lock-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

# Agregar una espera antes de crear la instancia EC2
resource "null_resource" "wait_for_table" {
  depends_on = [aws_dynamodb_table.terraform_lock_table]
  provisioner "local-exec" {
    command = "sleep 30"  # Espera de 30 segundos
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-0453ec754f44f9a4a"
  instance_type = "t3.micro"
  subnet_id     = "subnet-0167d706fb101e2ae"
  tags = {
    Name = var.instance_name
  }

  depends_on = [null_resource.wait_for_table]
}
