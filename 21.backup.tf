# AWS Backup Vault 생성
resource "aws_backup_vault" "example" {
  name = "example_backup_vault"
}


# Backup Plan 및 Policy 생성
resource "aws_backup_plan" "example" {
  name = "tf_example_backup_plan"
  rule {
    rule_name         = "tf_example_backup_rule"
    target_vault_name = "example_backup_vault"
    schedule          = "cron(0 12 * * ? *)"
    lifecycle {
      delete_after = 7 # delete after 7 days
    }
  }
  depends_on = [
    aws_backup_vault.example
  ]
}

resource "aws_iam_role" "default" {
  name               = "DefaultBackupRole"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "example" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.default.name
}

resource "aws_backup_selection" "example" {
  iam_role_arn = aws_iam_role.default.arn
  name         = "tf_example_backup_selection"
  plan_id      = aws_backup_plan.example.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "backup"
    value = "True"
  }
}
