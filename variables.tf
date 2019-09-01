variable "bastion_ip_address" {
  default = ""
}

variable "bastion_ssh_user" {
  default = ""
}

variable "bastion_ssh_password" {
  default = ""
}

variable "bastion_ssh_private_key" {
  default = ""
}

variable "ssh_private_key" {
  default = ""
}

variable "ssh_user" {
  default = "root"
}

variable "ssh_password" {
  default = ""
}

variable "num_nodes" {
  default = 0
}

variable "node_ips" {
  type = "list"
  default = []
}

variable "node_hostnames" {
  type = "list"
  default = []
}

variable "domain" {
  type = "string"
}