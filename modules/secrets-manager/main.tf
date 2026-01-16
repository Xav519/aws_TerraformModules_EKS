# Custom Secrets Manager Module

# KMS Key for Secrets Manager encryption (only created if at least one secret is enabled)
resource "aws_kms_key" "secrets" {
  count                   = var.create_db_secret || var.create_api_secret || var.create_app_config_secret ? 1 : 0
  description             = "KMS key for Secrets Manager encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-secrets-kms"
    }
  )
}

resource "aws_kms_alias" "secrets" {
  count         = var.create_db_secret || var.create_api_secret || var.create_app_config_secret ? 1 : 0
  name          = "alias/${var.name_prefix}-secrets"
  target_key_id = aws_kms_key.secrets[0].key_id
}