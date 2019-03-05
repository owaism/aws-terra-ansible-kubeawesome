[![Build Status](https://travis-ci.com/owaism/aws-terra-ansible-kubeawesome.svg?branch=owais-dev)](https://travis-ci.com/owaism/aws-terra-ansible-kubeawesome)


## Pre-Requisites

1. Install `pre-commit`. Visit https://pre-commit.com/. This is used to clean up the code before commiting to git.

2. Install `git secrets`. Visit https://github.com/awslabs/git-secrets. This is used to scan for aws credentials before a commit occurs.

3. Install Terraform v0.11.11. You can use brew as follows

	```
	brew install terraform
	terraform --version
	```

	In case brew installs a new version of terraform, you can search for terraform 0.11.11 and install it using brew
	```
	brew search terraform
	```

## Setup Environment Variables

Setup the following environment varibles on the build machine

Variable Name | Description
---|---
TF_VAR_public_key_base64| Base64 encoded Public Key of the SSH Key pair to use to login into VMs
TF_VAR_backend_s3_bucket_name | Bucket name of the S3 bucket to use as Terraform Backend
TF_VAR_aws_access_key | AWS Access Key
TF_VAR_aws_secret_key | AWS Access Secret
TF_VAR_aws_region | AWS Region. This is required only for terraform backend initialization. The actual AWS region for the build is picked up using the configs driven by `build_env` (see [configuration file](infrastructure/configs/ci/network.tfvars)). The regions must match. This unfortunate redundancy is because of the way terraform backened is initialized.
build_env | Provide the environment that is being built. This is what is used to pick up appropriate configurations. For starters you can use 'ci' as the build environment.