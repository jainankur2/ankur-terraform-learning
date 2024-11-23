resource "aws_s3_bucket" "example" {
  for_each = var.environments

  bucket = each.value
  tags = {
    Environment = each.key
  }
}