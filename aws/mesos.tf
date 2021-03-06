resource "aws_security_group" "mesos-sg" {
  name = "mesos-sg"
  description = "Mesos security group"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 5050
    to_port = 5050
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 5051
    to_port = 5051
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 2181
    to_port = 2181
    protocol = "tcp"
    #self = true # This will work in the next release of terrarform > v0.2.2
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "mesos-master" {
  instance_type = "m1.medium"
  ami = "${lookup(var.amis, var.region)}"
  count = 1
  key_name = "${var.key_name}"
  security_groups = ["${aws_security_group.mesos-sg.name}"]
  connection {
    user = "ubuntu"
    key_file = "${var.key_file}"
  }
  provisioner "remote-exec" {
    scripts = [
      "files/install-common.sh",
      "files/setup-master.sh"
    ]
  }
}

output "mesos-ui" {
  value = "http://${aws_instance.mesos-master.public_ip}:5050"
}

output "marathon-ui" {
  value = "http://${aws_instance.mesos-master.public_ip}:8080"
}

resource "aws_instance" "mesos-slave" {
  instance_type = "m1.medium"
  ami = "${lookup(var.amis, var.region)}"
  count = "${var.num_slaves}"
  key_name = "${var.key_name}"
  security_groups = ["${aws_security_group.mesos-sg.name}"]
  connection {
    user = "ubuntu"
    key_file = "${var.key_file}"
  }
  provisioner "remote-exec" {
    inline = [
      "echo ${aws_instance.mesos-master.private_ip} > /tmp/zk_master"
    ]
  }
  provisioner "remote-exec" {
    scripts = [
      "files/install-common.sh",
      "files/setup-slave.sh"
    ]
  }
}

output "mesos-slave-ips" {
  value = "${join(", ", aws_instance.mesos-slave.*.public_ip)}"
}
