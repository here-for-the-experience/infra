# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket         = "prod-redevops-terraform-state"
    dynamodb_table = "prod-redevops-terraform-lock-table"
    encrypt        = true
    key            = "db/terraform.tfstate"
    profile        = "terraform-prod"
    region         = "us-east-2"
  }
}
