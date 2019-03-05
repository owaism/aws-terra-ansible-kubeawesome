################################################
##    AWS config                              ##
################################################


terraform {
  # All the properties are put in using the properties passed during terraform init
  backend "s3" {}
}

provider "aws" {
  region = "${var.aws_region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

module "network" {
  source = "./network"
  vpc_name = "${var.vpc_name}"
  vpc_cidr = "${var.vpc_cidr}"
  igw_name = "${var.igw_name}"
  az_count="${var.az_count}"
  az_list="${var.az_list}"
  az_short_list="${var.az_short_list}"
  dmz_subnet_name="${var.dmz_subnet_name}"
  dmz_subnet_cidr_list="${var.dmz_subnet_cidr_list}"
  kube_controlplane_subnet_name="${var.kube_controlplane_subnet_name}"
  kube_controlplane_subnet_cidr_list="${var.kube_controlplane_subnet_cidr_list}"
  kube_worker_subnet_name="${var.kube_worker_subnet_name}"
  kube_worker_subnet_cidr_list="${var.kube_worker_subnet_cidr_list}"
}


module "security" {
  source = "./security"
  key_pair_name="${var.key_pair_name}"
  public_ssh_key_base64="${var.public_ssh_key_base64}"
}


module "vms" {
  source = "./vms"

  vm_owner_tag_value="${var.vm_owner_tag_value}"
  vm_project_tag_value="${var.vm_project_tag_value}"
  key_pair_name="${var.key_pair_name}"
  bastion_vm_name="${var.bastion_vm_name}"
  bastion_ami="${var.bastion_ami}"
  bastion_instance_type="${var.bastion_instance_type}"
  bastion_connection_user="${var.bastion_connection_user}"

  bastion_sg_id="${module.network.bastion_sg_id}"
  dmz_subnet_ids="${module.network.dmz_subnet_ids}"

}