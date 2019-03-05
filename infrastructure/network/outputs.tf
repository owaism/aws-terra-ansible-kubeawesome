output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "dmz_subnet_ids" {

  value = "${aws_subnet.dmz-subnets.*.id}"
}

output "kube_controlplane_subnet_ids" {

  value = "${aws_subnet.kube-controlplane-subnets.*.id}"
}

output "kube_worker_subnet_ids" {

  value = "${aws_subnet.kube-worker-subnets.*.id}"
}

output "kube_controlplane_sg_id" {
  value = "${aws_security_group.kube-controlplane-sg.id}"
}

output "kube_worker_sg_id" {
  value = "${aws_security_group.kube-worker-sg.id}"
}

output "bastion_sg_id" {
  value = "${aws_security_group.bastion-sg.id}"
}