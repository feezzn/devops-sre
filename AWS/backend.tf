resource "aws_s3_bucket" "felps_tf_state" {
  bucket = "felps-tf-state"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "felps_tf_state" {
  bucket = aws_s3_bucket.felps_tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}