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

resource "aws_dynamodb_table" "tfc_example_table" {
  name = "${var.db_table_name}-${random_pet.table_name.id}"
  hash_key       = "UUID"
  tags = {
    Name = "test100"
  }

  attribute {
    name = "UUID"
    type = "S"
  }
}
