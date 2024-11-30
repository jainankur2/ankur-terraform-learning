locals {
  name_suffix = "${var.account}-${var.environment}"
  common_tags = {
    environment = var.environment,
    account     = var.account
  }
}
