data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket  = "tf-state-bucket-058264555529"
    key     = "test/eks/terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = "tf-state-bucket-058264555529"
    key     = "test/vpc/terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
  }
}
