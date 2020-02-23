provider "aws" {
  profile = "default"
  region  = "us-west-2"
  version = "~> 2.50"
}

variable "aws_account_id" {
  type    = string
  default = "111111111111"
}

variable "bucket_name" {
  type    = string
  default = "some-bucket"
}

variable "default_user" {
  type    = string
  default = "some-user"
}
