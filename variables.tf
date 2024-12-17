variable "ec2_dynamodb" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}

variable "aws_s3_bucket" {
  description = "terraform-backup"
  type        = string
  default     = "value"
}

variable "region" {
  description = "Region aws para ec2 con dynamodb"
  type        = string
  default     = "us-east-1"
}