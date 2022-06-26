include "root" {
  path = find_in_parent_folders("aws.hcl")
}

terraform {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/terraform/vpc"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = {
  cidr_block          = local.env_vars.locals.vpc_cidr
  cidr_public_subnet  = local.env_vars.locals.public_subnet
  cidr_private_subnet = local.env_vars.locals.private_subnet
}