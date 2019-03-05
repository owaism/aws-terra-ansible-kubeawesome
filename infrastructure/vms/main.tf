resource "aws_instance" "bastion" {
  connection {
    # The default username for our AMI
    user = "${var.bastion_connection_user}"
  }

  instance_type = "${var.bastion_instance_type}"

  ami = "${var.bastion_ami}"

  # The name of our SSH keypair we created above.
  key_name = "${var.key_pair_name}"

  vpc_security_group_ids = ["${var.bastion_sg_id}"]

  subnet_id = "${var.dmz_subnet_ids[0]}"

  associate_public_ip_address = true

  tags = {
    Name = "${var.bastion_vm_name}",
    Owner = "${var.vm_owner_tag_value}",
    Project = "${var.vm_project_tag_value}",
  }
}
