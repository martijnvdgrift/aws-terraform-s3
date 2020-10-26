provider "aws" {
  version = "~> 1.2"
  region  = "us-west-2"
}

resource "random_string" "s3_rstring" {
  length  = 18
  upper   = false
  special = false
}

module "s3" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-s3//?ref=v0.0.5"

  bucket_name = "${random_string.s3_rstring.result}-example-s3-bucket"

  bucket_acl = "bucket-owner-full-control"

  bucket_logging = false

  bucket_tags = {
    RightSaid = "Fred"
    LeftSaid  = "George"
  }

  environment = "Development"

  lifecycle_enabled = true

  noncurrent_version_expiration_days = "425"

  noncurrent_version_transition_glacier_days = "60"

  noncurrent_version_transition_ia_days = "30"

  object_expiration_days = "425"

  transition_to_glacier_days = "60"

  transition_to_ia_days = "30"

  versioning = true

  website = true

  website_error = "error.html"

  website_index = "index.html"
}
