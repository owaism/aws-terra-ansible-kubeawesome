Build Status: [![Build Status](https://travis-ci.com/owaism/aws-terra-ansible-kubeawesome.svg?branch=owais-dev)](https://travis-ci.com/owaism/aws-terra-ansible-kubeawesome)

### Environment Variables to setup

Variable Name | Description
---|---
TF_VAR_public_key_base64| Base64 encoded Public Key of the SSH Key pair to use for loging into VMs
TF_VAR_backend_s3_bucket_name | Bucket name of the S3 bucket to use as Terraform Backend
TF_VAR_aws_access_key | AWS Access Key
TF_VAR_aws_secret_key | AWS Access Secret
TF_VAR_aws_region | AWS Region