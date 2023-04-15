resource "aws_s3_bucket" "frontend_s3_bucket" {
  bucket = "kyle-mcv-frontend-s3-bucket"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}

resource "aws_s3_bucket_policy" "my_aws_s3_bucket_policy" {
  bucket = aws_s3_bucket.frontend_s3_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
         Resource  = "${aws_s3_bucket.frontend_s3_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket" "backend_s3_bucket" {
  bucket = "kyle-mcv-backend-s3-bucket"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}