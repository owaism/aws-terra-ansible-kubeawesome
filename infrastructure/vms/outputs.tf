output "bastion_info" {
  value = "ssh ${aws_instance.bastion.public_ip}"
}