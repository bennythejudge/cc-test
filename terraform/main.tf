provider "aws" {
  region  = "us-west-2"
  profile = "default"
}

resource "aws_vpc" "vpc" {
  cidr_block = "172.16.0.0/16"
  tags {
    Name = "vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "172.16.2.0/28"
  availability_zone = "us-west-2a"

  tags {
    Name = "public_subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "igw"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "route_table"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.route_table.id}"
}

resource "aws_key_pair" "public_key" {
  key_name   = "public_key"
  public_key = "${file("files/cc_rsa.pub")}"
}

resource "aws_security_group" "allow_ssh_from_home" {
  name        = "allow_ssh_from_home"
  description = "allow_ssh_from_home"
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["83.217.154.175/32"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_iam_server_certificate" "elb_cert" {
  name_prefix       = "letfdemo-cert-"
  certificate_body  = "${module.acme-cert.certificate_pem}"
  certificate_chain = "${module.acme-cert.certificate_issuer_pem}"
  private_key       = "${module.acme-cert.certificate_private_key_pem}"

  lifecycle {
    create_before_destroy = true
  }
}

#ELB security group (ensure its accessible via the web)
resource "aws_security_group" "elb" {
  name        = "cc-sg-elb"
  description = "ELB security group"
  vpc_id      = "${aws_vpc.vpc.id}"

  # HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "cc-sg-elb"
    Purpose = "cc"
  }
}

resource "aws_elb" "web" {
  name = "cc-elb-www"
  
  subnets         = ["${aws_subnet.public_subnet.id}"]
  security_groups = ["${aws_security_group.elb.id}"]
  instances       = ["${aws_instance.EC2-cctest.*.id}"]

  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "${aws_iam_server_certificate.elb_cert.arn}"

  }

  tags {
    Name    = "cc-elb-www"
    Purpose = "CompuCorp exercise"
  }
}

resource "aws_instance" "EC2-cctest" {
  ami           = "ami-6e1a0117"
  instance_type = "t2.micro"
  subnet_id     = "${aws_subnet.public_subnet.id}"
  key_name      = "${aws_key_pair.public_key.id}"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.allow_ssh_from_home.id}",
                            "${aws_security_group.elb.id}"]
  user_data = "${file("cloud-config/app.yml")}"

  tags {
    Name = "EC2-cctest"
  }
}

resource "aws_kms_key" "key" {
  description   = "KMS key 1"
}

data "aws_kms_ciphertext" "mysql_root_password" {
  key_id = "${aws_kms_key.key.key_id}"
  plaintext = "${var.mysql_root_password}"
}

data "aws_kms_ciphertext" "mysql_drupal_password" {
  key_id = "${aws_kms_key.key.key_id}"
  plaintext = "${var.mysql_drupal_password}"
}

data "aws_kms_ciphertext" "mysql_civicrm_password" {
  key_id = "${aws_kms_key.key.key_id}"
  plaintext = "${var.mysql_civicrm_password}"
}
