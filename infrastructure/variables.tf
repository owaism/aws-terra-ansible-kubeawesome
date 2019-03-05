
########### Following variables are setup using the Host machines Environment Variables ##############

## Picked for Security Config Files
variable "key_pair_name" {
  description = "Name of the AWS Key Pair to be used to log into machines"
}

## Environment Variable: TF_VAR_public_key_path
variable "public_ssh_key_base64" {
  description ="Public ssh key (SSH Key Pair)"
}

## Environment Variable: TF_VAR_backend_s3_bucket_name
variable "aws_terraform_bucket" {
  description = "S3 bucket name where Terraform info is stored"
  default = "kube_awesome"
}

## Environment Variable: TF_VAR_aws_access_key
variable "aws_access_key" {
  description = "AWS access key"
}

## Environment Variable: TF_VAR_aws_secret_key
variable "aws_secret_key" {
  description = "AWS secret key"
}

## Environment Variable: TF_VAR_aws_region
variable "aws_region" {
  description = "AWS Region where the cluster has to be brought up"
  default     = "us-east-1"
}


####################################################################
######### Network Variables
####################################################################

variable "vpc_name" {
  description = "Pickedup from Configuration files. This is the name of the VPC to be created or maintained"
}

variable "vpc_cidr" {
  description = "Pickedup from Configuration files. CIDR of the VPC to be created or maintained"
}


variable "igw_name" {
  description = "Pickedup from Configuration files. Name of the Internet Gateway"
}

variable "az_count" {
  description = "picked up from networks configuration file"
}

variable "az_list" {
  type="list"
  description = "picked up from networks configuration file"
  default=[]
}

variable "az_short_list" {
  type="list"
  description = "picked up from networks configuration file"
  default=[]
}

variable "dmz_subnet_name" {
  description = "picked up from networks configuration file"
}

variable "dmz_subnet_cidr_list" {
  type="list"
  description = "picked up from networks configuration file"
  default=[]
}

variable "kube_controlplane_subnet_name" {
  description = "picked up from networks configuration file"
}

variable "kube_controlplane_subnet_cidr_list" {
  type="list"
  description = "picked up from networks configuration file"
  default=[]
}

variable "kube_worker_subnet_name" {
  description = "picked up from networks configuration file"
}

variable "kube_worker_subnet_cidr_list" {
  type="list"
  description = "picked up from networks configuration file"
  default=[]
}


################################################
## VM Variables
################################################


variable "vm_owner_tag_value" {
  default="Owais"
}
variable "vm_project_tag_value" {
  default="kube-awesome"
}
variable "bastion_vm_name" {
  default="bastion"
}
variable "bastion_ami" {}

variable "bastion_connection_user" {}

variable "bastion_instance_type" {}
