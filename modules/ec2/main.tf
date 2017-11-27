resource "aws_instance" "ec2_instance" {
  count = "${var.number_of_instances}"
  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  key_name = "${var.ssh_access_key}"
  security_groups = ["${var.security_group_id}"]
  subnet_id = "${var.subnet_id}"
  source_dest_check = "${var.source_dest_check}"
  associate_public_ip_address = "${var.associate_public_ip_address}"

  root_block_device {
    volume_size = "${var.root_block_device_size}"
  }

  tags {
    Name = "${var.project_name}_${var.environment}_${var.instance_name}"
    for_ansible = "${var.ansible_ref_tag_name}"
    id = "${var.ec2_id}"
  }
}
