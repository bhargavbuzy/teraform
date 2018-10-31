############
## VPC
############

resource "aws_vpc" "demo" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "${var.vpc_name}"
    Owner = "${var.owner}"
  }
}

##########
# Keypair
##########

resource "aws_key_pair" "default_keypair" {
  key_name = "${var.default_keypair_name}"
  public_key = "${var.default_keypair_public_key}"
}


############
## Subnets
############

# Subnet (public)
resource "aws_subnet" "demo" {
  vpc_id = "${aws_vpc.demo.id}"
  cidr_block = "${var.subnet_cidr}"
  availability_zone = "${var.zone}"

  tags {
    Name = "demo"
    Owner = "${var.owner}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.demo.id}"
  tags {
    Name = "demo"
    Owner = "${var.owner}"
  }
}

############
## Routing
############

resource "aws_route_table" "demo" {
    vpc_id = "${aws_vpc.demo.id}"

    # Default route through Internet Gateway
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.gw.id}"
    }

    tags {
      Name = "demo"
      Owner = "${var.owner}"
    }
}

resource "aws_route_table_association" "demo" {
  subnet_id = "${aws_subnet.demo.id}"
  route_table_id = "${aws_route_table.demo.id}"
}


############
## Security
############

resource "aws_security_group" "demo" {
  vpc_id = "${aws_vpc.demo.id}"
  name = "demo"

  # Allow all outbound
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow ICMP from control host IP
  ingress {
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["${var.control_cidr}"]
  }

  # Allow all internal
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  # Allow all traffic from the API ELB
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = ["${aws_security_group.demo.id}"]
  }

  # Allow all traffic from control host IP
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["${var.control_cidr}"]
  }

  tags {
    Owner = "${var.owner}"
    Name = "demo"
  }
}
