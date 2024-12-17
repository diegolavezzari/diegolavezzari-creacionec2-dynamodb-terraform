output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "dynamodb_table" {
  description = "Nombre de la tabla"
  value       = aws_dynamodb_table.terraform_state_lock
}

output "aws_s3_bucket" {
  description = "Nombre-S3"
  value       = aws_s3_bucket.terraform_state

}