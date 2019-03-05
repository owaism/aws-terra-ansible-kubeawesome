variable "vpc_name" {
  description = "Picked up from Configuration files. This is the name of the VPC to be created or maintained"
}

variable "vpc_cidr" {
  description = "Picked up from Configuration files. CIDR of the VPC to be created or maintained"
}

variable "igw_name" {
  description = "Picked up from Configuration files. Name of the Internet Gateway"
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
