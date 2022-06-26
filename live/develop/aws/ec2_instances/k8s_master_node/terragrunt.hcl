include "root" {
  path = find_in_parent_folders("aws.hcl")
}

dependency "k8s_vpc" {
  config_path = "${dirname(find_in_parent_folders("aws.hcl"))}/vpc/k8s"
  mock_outputs = {
    private_subnet_id = "private_subnet_id"
  }
}

inputs = {
  subnet_id = dependency.k8s_vpc.outputs.private_subnet_id
}

terraform {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/terraform/ec2"
}