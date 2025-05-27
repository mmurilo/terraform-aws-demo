data "http" "myip" {
  url = "https://ifconfig.me/ip"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = "tf-state-bucket-918998335591"
    key     = "test/vpc/terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
  }
}
