# terraform-dns-etc-hosts

This terraform module is intended to generate `/etc/hosts` across a set of machines using SSH as a hacky replacement for DNS, or as a way of ensuring correct interfaces in multi-homed environments (such as in IBM Cloud classic infrastructure).
