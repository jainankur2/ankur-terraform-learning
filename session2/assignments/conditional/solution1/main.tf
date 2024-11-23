resource "aws_s3_bucket" "example" {
  count = var.enable_bucket ? 1 : 0

  bucket = "conditional-bucket-${random_id.bucket_id.hex}"
  tags = {
    Name = "ConditionalBucket"
  }
}

# Random ID for Unique Bucket Name
resource "random_id" "bucket_id" {
  byte_length = 4
}