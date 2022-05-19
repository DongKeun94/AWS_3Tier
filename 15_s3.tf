# S3 Bucket 생성
resource "aws_s3_bucket" "digda-bucket" {
  bucket = "digda-bucket"
  acl    = "private"
}

# 생성한 S3 Bucket의 Public 접근 차단
resource "aws_s3_bucket_public_access_block" "digda" {
  bucket = aws_s3_bucket.digda-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
