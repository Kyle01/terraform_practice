resource "aws_s3_bucket" "frontend_s3_bucket" {
  bucket = "kyle-mcv-frontend-s3-bucket"
  acl    = "private"
}
