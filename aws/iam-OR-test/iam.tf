data "aws_iam_policy_document" "scenario_1_fail1" {
  statement {
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:List*"
    ]
    resources = [
      "arn:aws:s3:::cnc-example-bucket-foo-bar",
      "arn:aws:s3:::cnc-example-bucket-foo-bar/*" ### PASS
    ]
  }
  statement {
    effect = "xyz"
    actions = [
      "iam:*",
      "s3:List*"
    ]
    resources = ["arn:aws:s3:::cnc-*"]  ### FAIL
  }
}

data "aws_iam_policy_document" "scenario_1_fail2" {
  statement {
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:List*"
    ]
    resources = [
      "arn:aws:s3:::cnc-example-bucket-foo-bar",
      "arn:aws:s3:::cnc-example-bucket-foo-bar/*" ### PASS
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "iam:*",
      "s3:List*"
    ]
    resources = ["arn:aws:s3:::cnc-*"]  ### FAIL
  }
}

data "aws_iam_policy_document" "scenario_1_pass1" {
  statement {
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:List*"
    ]
    resources = [
      "arn:aws:s3:::cnc-example-bucket-foo-bar",
      "arn:aws:s3:::cnc-example-bucket-foo-bar/*" ### PASS
    ]
  }
  statement {
    effect = "Deny"
    actions = [
      "iam:*",
      "s3:List*"
    ]
    resources = ["arn:aws:s3:::cnc-*"]  ### FAIL
  }
}

data "aws_iam_policy_document" "scenario_1_fail3" {
  statement {
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:List*"
    ]
    resources = [
      "arn:aws:s3:::cnc-example-bucket-foo-bar",
      "arn:aws:s3:::cnc-example-bucket-foo-bar/*" ### PASS
    ]
  }
  statement {
    actions = [
      "iam:*",
      "s3:List*"
    ]
    resources = ["arn:aws:s3:::cnc-*"]  ### FAIL
  }
}