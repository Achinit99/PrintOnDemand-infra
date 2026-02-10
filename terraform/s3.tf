# s3.tf

# 1. Frontend for S3 Bucket create
resource "aws_s3_bucket" "frontend_bucket" {
  bucket = "${var.project_name}-frontend-bucket-unique-id" # මේක unique නමක් වෙන්න ඕනේ

  tags = {
    Name = "frontend-bucket"
  }
}

# 2. Bucket - Public Access Block (Industry Standard)
resource "aws_s3_bucket_public_access_block" "frontend_bucket_block" {
  bucket = aws_s3_bucket.frontend_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}