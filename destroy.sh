#!/bin/sh

# Destroying the infrastructure

cd ./infrastructure

terraform destroy -auto-approve \
	-var-file=configs/$build_env/network.tfvars \
	-var-file=configs/$build_env/security.tfvars \
	-var-file=configs/$build_env/vms.tfvars