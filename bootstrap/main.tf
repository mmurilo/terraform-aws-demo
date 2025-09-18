module "s3_backend" {
  source = "github.com/mmurilo/terraform-modules//s3-backend-bootstrap?ref=s3-backend-bootstrap-v0.2.1"
  region = var.aws_region
}


provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Envioremnt = test
      Managed_by = "terraform"
    }
  }
}

variable "aws_region" {
  default = "us-west-2"
}

output "backend" {
  value = module.s3_backend
}
