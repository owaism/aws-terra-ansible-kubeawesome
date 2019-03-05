###############################################
# Creating VPC
###############################################

resource "aws_vpc" "vpc" {
  cidr_block       = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.vpc_name}"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "${var.igw_name}"
  }
}


##################################################
# Creating all subnets
##################################################

resource "aws_subnet" "dmz-subnets" {
  count="${var.az_count}"
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.dmz_subnet_cidr_list[count.index]}"
  availability_zone = "${var.az_list[count.index]}"

  tags = {
    Name = "${var.dmz_subnet_name}-${var.az_short_list[count.index]}"
  }
}


resource "aws_subnet" "kube-controlplane-subnets" {
  count="${var.az_count}"
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.kube_controlplane_subnet_cidr_list[count.index]}"
  availability_zone = "${var.az_list[count.index]}"

  tags = {
    Name = "${var.kube_controlplane_subnet_name}-${var.az_short_list[count.index]}"
  }
}


resource "aws_subnet" "kube-worker-subnets" {
  count="${var.az_count}"
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.kube_worker_subnet_cidr_list[count.index]}"
  availability_zone = "${var.az_list[count.index]}"

  tags = {
    Name = "${var.kube_worker_subnet_name}-${var.az_short_list[count.index]}"
  }
}

##################################################
# Creating NAT Gateways
##################################################

resource "aws_eip" "nat_eips" {
  count = "${var.az_count}"
  vpc = true
}

resource "aws_nat_gateway" "nat-gateways" {
  count = "${var.az_count}"

  subnet_id ="${aws_subnet.dmz-subnets.*.id[count.index]}"
  allocation_id ="${aws_eip.nat_eips.*.id[count.index]}"

  tags = {
    Name = "dmz-${var.az_short_list[count.index]}"
  }
}

##################################################
# Creating Route Tables
##################################################

resource "aws_route_table" "dmz-route-tables" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block        = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "dmz-route-table"
  }
}


resource "aws_route_table" "private-route-tables" {
  count = "${var.az_count}"
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block        = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat-gateways.*.id[count.index]}"
  }

  tags = {
    Name = "private-${var.az_short_list[count.index]}"
  }
}


##################################################
# Creating Route Tables Associations
##################################################

resource "aws_route_table_association" "dmz-associations" {
  count = "${var.az_count}"
  subnet_id = "${aws_subnet.dmz-subnets.*.id[count.index]}"
  route_table_id = "${aws_route_table.dmz-route-tables.id}"
}

resource "aws_route_table_association" "kube-controlplane-associations" {
  count = "${var.az_count}"
  subnet_id = "${aws_subnet.kube-controlplane-subnets.*.id[count.index]}"
  route_table_id = "${aws_route_table.private-route-tables.*.id[count.index]}"
}

resource "aws_route_table_association" "kube-worker-associations" {
  count = "${var.az_count}"
  subnet_id = "${aws_subnet.kube-worker-subnets.*.id[count.index]}"
  route_table_id = "${aws_route_table.private-route-tables.*.id[count.index]}"
}



###########################################################
# Security Groups
###########################################################


resource "aws_security_group" "kube-controlplane-sg" {
  name        = "kube-controlplane-sg"
  description = "Security group for the kube-controlplane subnet"
  vpc_id = "${aws_vpc.vpc.id}"

  /* Open to All machines within the cluster */
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "kube-controlplane-sg"
  }
}


resource "aws_security_group" "kube-worker-sg" {
  name        = "kube-worker-sg"
  description = "Security group for the kube-worker subnet"
  vpc_id = "${aws_vpc.vpc.id}"

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "kube-worker-sg"
  }
}


resource "aws_security_group_rule" "kube-worker-ingress-rules" {
  type            = "ingress"
  from_port       = 0
  to_port         = 65535
  protocol        = "tcp"
  # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
  cidr_blocks = ["${aws_subnet.kube-controlplane-subnets.*.cidr_block}"]

  security_group_id = "${aws_security_group.kube-worker-sg.id}"
}


resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg"
  description = "Security group for the Bastion Server"
  vpc_id = "${aws_vpc.vpc.id}"

  /* Open to All machines within the cluster */
  ingress {
    from_port   = 0
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "bastion-sg"
  }
}
