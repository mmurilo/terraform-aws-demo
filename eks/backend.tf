terraform {
  backend "s3" {
    bucket       = "tf-state-bucket-058264555529"
    key          = "test/eks/terraform.tfstate"
    region       = "us-west-2"
    encrypt      = true
    use_lockfile = true
  }
}
