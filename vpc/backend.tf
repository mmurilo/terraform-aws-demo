terraform {
  backend "s3" {
    bucket       = "tf-state-bucket-918998335591"
    key          = "test/vpc/terraform.tfstate"
    region       = "us-west-2"
    encrypt      = true
    use_lockfile = true
  }
}
