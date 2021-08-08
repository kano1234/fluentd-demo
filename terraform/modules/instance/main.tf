locals {
  ami = var.ami == "" ? data.aws_ami.amzn2_latest.id : var.ami
}

data "aws_ami" "amzn2_latest" {
  most_recent = true
  name_regex  = "^amzn2-ami-hvm-.+-x86_64-gp2$"
  owners      = ["amazon"]
}

resource "aws_instance" "this" {
  count                       = var.disable ? 0 : 1
  ami                         = local.ami
  associate_public_ip_address = true
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  iam_instance_profile        = var.iam_instance_profile
  vpc_security_group_ids      = var.vpc_security_group_ids
  capacity_reservation_specification {
    capacity_reservation_preference = "none"
  }
  tags = merge(tomap({ Name = "${var.env}-${var.system}-ec2" }), var.tags)
}