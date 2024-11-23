output "bucket_names" {
  value = [for x in aws_s3_bucket.example: x.id]
}