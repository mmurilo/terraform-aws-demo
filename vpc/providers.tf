provider "aws" {
  region = local.vars.aws_region
  default_tags {
    tags = local.vars.default_tags
  }
}
