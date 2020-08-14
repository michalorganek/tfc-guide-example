terraform {
  backend "remote" {
    organization = "michal-organek"

    workspaces {
      name = "test"
    }
  }
}

provider "aws" {
  version = "2.33.0"

  region = var.aws_region
}

provider "random" {
  version = "2.2"
}

resource "random_pet" "table_name" {}

resource "aws_s3_bucket" "mybucket" {
  bucket = "my-tf-test-bucket-${random_pet.table_name.id}"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
