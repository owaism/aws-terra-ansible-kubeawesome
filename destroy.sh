#!/bin/sh

# Destroying the infrastructure

cd ./infrastructure

terraform destroy -auto-approve -var-file=configs/us-east-1/network.tfvars -var-file=configs/us-east-1/security.tfvars -var-file=configs/us-east-1/vms.tfvars