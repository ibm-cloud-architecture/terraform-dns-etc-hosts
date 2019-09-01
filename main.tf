data "template_file" "etc_hosts" {
  template = <<EOF
${join("\n", formatlist("%v %v.%v %v",
  var.node_ips,
  var.node_hostnames,
  var.domain,
  var.node_hostnames))}
EOF
}


resource "null_resource" "sync_etc_hosts" {
  count = "${var.num_nodes}"

  triggers = {
      hosts = "${data.template_file.etc_hosts.rendered}"
  }

  connection {
    type = "ssh"

    host        = "${element(var.node_ips, count.index)}"
    user        = "${var.ssh_user}"
    password    = "${var.ssh_password}"
    private_key = "${var.ssh_private_key}"

    bastion_host        = "${var.bastion_ip_address}"
    bastion_user        = "${var.bastion_ssh_user}"
    bastion_password    = "${var.bastion_ssh_password}"
    bastion_private_key = "${var.bastion_ssh_private_key}"
  }

  provisioner "file" {
    content = "${data.template_file.etc_hosts.rendered}"
    destination = "/tmp/etc_hosts"
  }

  provisioner "file" {
    source      = "${path.module}/scripts/sync_etc_hosts.sh"
    destination = "/tmp/sync_etc_hosts.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/sync_etc_hosts.sh",
      "sudo /tmp/sync_etc_hosts.sh",
      "rm -f /tmp/sync_etc_hosts.sh"
    ]
  }
}
