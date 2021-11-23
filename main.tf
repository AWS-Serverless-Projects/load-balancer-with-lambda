variable "REGION" { default="eu-central-1" }
variable "PROFILE" { default="default" }

provider "aws" {
  profile = var.PROFILE
  region = var.REGION
}
