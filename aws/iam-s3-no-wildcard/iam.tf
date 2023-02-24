# Shared Info
## Specify current session info
# data "aws_caller_identity" "current" {}

## Example role to attach role policies to
resource "aws_iam_role" "example_role" {
  name                 = "cnc-example"
  assume_role_policy   = data.aws_iam_policy_document.example_trust.json
  permissions_boundary = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/lz/power-user"
}
## Trust Policy for example role
data "aws_iam_policy_document" "example_trust" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Scenario 1 
##  IAM Policy documents that have statements granting any s3 actions that have a * in any of the specified resources for that statement.
resource "aws_iam_role_policy" "scenario_1_fail" {
  name   = "scenario-1-fail"
  role   = aws_iam_role.example_role.id
  policy = data.aws_iam_policy_document.scenario_1_fail.json
}

data "aws_iam_policy_document" "scenario_1_fail" {
  statement {
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:List*"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "scenario_2_fail" {
  statement {
    effect = "Allow"
    actions = [
      "s3:List*",
      "*"
    ]
    resources = ["arn:aws:s3:::cnc-*"]
  }
}

data "aws_iam_policy_document" "scenario_3_fail" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    resources = ["arn:aws:s3:::cnc-*"]
  }
}

data "aws_iam_policy_document" "scenario_4_fail" {
  statement {
    effect = "Allow"
    actions = [
      "s3:*"
    ]
    resources = ["arn:aws:s3:::cnc-*"]
  }
}

resource "aws_iam_role_policy" "scenario_1_pass" {
  name   = "scenario-1-pass"
  role   = aws_iam_role.example_role.id
  policy = data.aws_iam_policy_document.scenario_1_pass.json
}

data "aws_iam_policy_document" "scenario_1_pass" {
  statement {
    effect = "Allow"

    actions = [
      "s3:List*"
    ]

    resources = [
      "arn:aws:s3:::cnc-*"
    ]
  }
}

data "aws_iam_policy_document" "scenario_2_pass" {
  statement {
    effect = "Allow"

    actions = [
      "s3:*"
    ]

    resources = [
      "arn:aws:s3:::cnc-example-bucket-foo-bar"
    ]
  }
}

data "aws_iam_policy_document" "scenario_3_pass" {
  statement {
    effect = "Deny"
    actions = [
      "s3:Get*",
      "s3:List*"
    ]
    resources = ["*"]
  }
}