# terraform-dns-etc-hosts

This terraform module is intended to generate `/etc/hosts` across a set of machines using SSH as a hacky replacement for DNS, or as a way of ensuring correct interfaces in multi-homed environments (such as in IBM Cloud classic infrastructure).

## example usage

```
module "etchosts" {
    source = "github.com/ibm-cloud-architecture/terraform-dns-etc-hosts.git?ref=1.1"

    bastion_ip_address      = "<bastion host ip address>"
    bastion_ssh_user        = "<ssh username>"
    bastion_ssh_private_key = "<ssh private key>"

    ssh_user           = "<ssh username>"
    ssh_private_key    = "<ssh private key>"
    
    num_nodes = "3"
    node_ips                = [<ip1>, <ip2>, <ip3>]
    node_hostnames          = [<hostname1>, <hostname2>, <hostname3>]

    domain                  = "my-domain.com

}
```