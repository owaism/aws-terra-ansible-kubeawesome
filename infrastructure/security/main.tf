
## Creating SSH Key pair
resource "aws_key_pair" "kube-awesome-keypair" {
  key_name   = "${var.key_pair_name}"
  public_key = "${base64decode(var.public_ssh_key_base64)}"
}