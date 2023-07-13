terraform {
  source = "../../../modules/db"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

inputs = {
  eks_version = "1.26"
  env         = include.env.locals.env
  eks_name    = "demo"
  subnet_ids  = dependency.vpc.outputs.public_subnet_ids # Change to private
  
  db_password = "super~secret~password"
  vpc_id      = dependency.vpc.outputs.vpc_id
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    public_subnet_ids = ["subnet-1234", "subnet-5678"] # Change to private
  }
}
