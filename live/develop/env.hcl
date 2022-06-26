locals {
  env            = "develop" # this will be prod in the prod folder, and stage in the stage folder.
  vpc_cidr       = "10.5.0.0/16"
  private_subnet = "10.5.0.0/24"
  public_subnet  = "10.5.1.0/24"
}