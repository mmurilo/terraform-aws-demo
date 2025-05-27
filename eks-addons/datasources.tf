data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket  = "tf-state-bucket-918998335591"
    key     = "test/eks/terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
  }
}
