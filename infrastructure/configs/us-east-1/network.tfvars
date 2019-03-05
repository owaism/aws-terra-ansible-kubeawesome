
########### Following variables are used to setup the network ##############


############################
###### VPC Properties
############################
vpc_name="terra-kubeawesome-vpc"
vpc_cidr="10.0.0.0/16"

igw_name="terra-kubeawesome-igw"

az_count=3
az_list=["us-east-1b","us-east-1c","us-east-1d"]
az_short_list=["1b","1c","1d"]

dmz_subnet_name="kubeawesome-dmz"
dmz_subnet_cidr_list=["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]

kube_controlplane_subnet_name="kubeawesome-controlplane"
kube_controlplane_subnet_cidr_list=["10.0.11.0/24","10.0.12.0/24","10.0.13.0/24"]

kube_worker_subnet_name="kubeawesome-worker"
kube_worker_subnet_cidr_list=["10.0.21.0/24","10.0.22.0/24","10.0.23.0/24"]