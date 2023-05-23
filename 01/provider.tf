provider "aws" {
  shared_credentials_files = [var.context.aws_credentials_file]
  region = var.context.aws_region
  profile = var.context.aws_profile
}