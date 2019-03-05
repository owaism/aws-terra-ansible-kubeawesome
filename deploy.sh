#!/bin/sh

## Starting with Terraform Infrastructure setup

cd ./infrastructure

terraform init \
	-backend=true \
	-backend-config="bucket="$TF_VAR_backend_s3_bucket_name \
	-backend-config="region="$TF_VAR_aws_region \
	-backend-config="access_key="$TF_VAR_aws_access_key \
	-backend-config="secret_key="$TF_VAR_aws_secret_key \
	-backend-config="key=owais_terra_kubeawesome.tf"


terraform apply -auto-approve -var-file=configs/us-east-1/network.tfvars -var-file=configs/us-east-1/security.tfvars -var-file=configs/us-east-1/vms.tfvars