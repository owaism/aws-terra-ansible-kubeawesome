## Picked for Security Config Files
variable "key_pair_name" {
  description = "Name of the AWS Key Pair to be used to log into machines"
}

## Environment Variable: TF_VAR_public_key_path
variable "public_ssh_key_base64" {
  description ="Public SSH Key (SSH Key Pair)"
}

