provider "aws" {
  region = "us-east-2"
}

provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2"
}