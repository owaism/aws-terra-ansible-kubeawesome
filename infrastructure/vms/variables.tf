
##############################
## Common
##############################
variable "vm_owner_tag_value" {
  default="Owais"
}
variable "vm_project_tag_value" {
  default="kube-awesome"
}

## Picked for Security Config Files
variable "key_pair_name" {
  description = "Name of the AWS Key Pair to be used to log into machines"
}

##############################
## Bastion
##############################
variable "bastion_vm_name" {
  default="bastion"
}

variable "bastion_ami" {}

variable "bastion_connection_user" {}

variable "bastion_instance_type" {}

variable "bastion_sg_id" {}

variable "dmz_subnet_ids" {
  type = "list"
  default = []
}