module "runplaybook" {
  source = "github.com/ibm-cloud-architecture/terraform-ansible-runplaybooks"

  dependson = "${var.dependson}"

  ansible_playbook_dir = "${path.module}/playbooks"
  ansible_playbooks = [
      "playbooks/generate_etchosts.yaml"
  ]

  ssh_user           = "${var.ssh_user}"
  ssh_password       = "${var.ssh_password}"
  ssh_private_key    = "${var.ssh_private_key}"

  bastion_ip_address       = "${var.bastion_ip_address}"
  bastion_ssh_user         = "${var.bastion_ssh_user}"
  bastion_ssh_password     = "${var.bastion_ssh_password}"
  bastion_ssh_private_key  = "${var.bastion_ssh_private_key}"

  node_ips = "${var.node_ips}"
  node_hostnames = "${var.node_hostnames}"

  triggerson = {
    node_ips = "${join(",", var.node_ips)}"
    node_hostnames = "${join(",", var.node_hostnames)}"
  }

  # ansible_verbosity = "-vvv"
}

