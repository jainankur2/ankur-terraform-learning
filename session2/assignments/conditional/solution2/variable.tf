variable "performance" {
  description = "Performance level for the EC2 instance (high, medium, or low)"
  type        = string
  default     = "low"
}

variable "ami_id" {
  description = "AMI ID to use for the EC2 instances"
  type        = string
  default     = "ami-0866a3c8686eaeeba" # Replace with a valid AMI ID
}