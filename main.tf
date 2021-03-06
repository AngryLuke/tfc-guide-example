terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {

  region = var.aws_region
}

provider "random" { }

resource "random_pet" "table_name" {}

resource "aws_dynamodb_table" "tfc_example_table" {
  name = "${var.db_table_name}-${random_pet.table_name.id}"

  read_capacity  = var.db_read_capacity
  write_capacity = var.db_write_capacity
  hash_key       = "UUID"
  range_key      = "UserName"

  attribute {
    name = "UUID"
    type = "S"
  }


  attribute {
    name = "UserName"
    type = "S"
  }
  
  tags = {
    Name      = "DynamoDB - demo resource"
    #owner     = "lbolli@hashicorp.com"
    ttl       = 48
    se-region = "emea-se"
    purpose   = "test and learning"
    terraform = "true"
  }
}
