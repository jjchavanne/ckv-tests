resource "aws_s3_bucket_policy" "bucket" {
    bucket = aws_s3_bucket.bucket.id
    policy = jsonencode({
        "Version" = "2012-10-17"
        "Id"      = "BUCKET-POLICY"
        "Statement" = [
            {
                "Sid"       = "EnforceTlsmisconfiguration"
                "Effect"    = "Allow"
                "Principal" = "*"
                "Action"    = [
                    "s3:*"
                ]
                "Resource" = [
                    "${aws_s3_bucket.bucket.arn}/*",
                    "${aws_s3_bucket.bucket.arn}",
                ]
                "Condition" = {
                    "Bool" = {
                        "aws:SecureTransport" = "false"
                    }
                }
            }
          ]
    })
}