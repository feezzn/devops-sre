output "s3_arn" {
    description = "ARN of the S3 bucket"
    value      = aws_s3_bucket.felps_tf_state.arn
}

output "s3_bucket_name" {
    description = "Name of the S3 bucket"
    value      = aws_s3_bucket.felps_tf_state.bucket
}