## Environment Variable: TF_VAR_backend_s3_bucket_name
variable "aws_terraform_bucket" {
  description = "S3 bucket name where Terraform info is stored"
  default = "kube_awesome"
}

## Environment Variable: TF_VAR_aws_shared_file_path
variable "aws_creds_file_path" {
  description = "Path of the file containing AWS Access Key and Secret"
  default = "aws_creds.tfvars"
}

## Environment Variable: TF_VAR_aws_creds_profile_name
variable "aws_creds_profile_name" {
  description = "Profile name to be used from the creds file"
  default = "kube_awesome"
}

## Environment Variable: TF_VAR_aws_region
variable "aws_region" {
  description = "AWS Region where the cluster has to be brought up"
  default     = "us-east-1"
}