#!/bin/bash

exec 3>&1 4>&2 1> >(tee $0.log.$$ >&3) 2> >(tee $0.log.$$ >&4)

hostname_fqdn=`hostname -f`

set -x

if [ ! -f /etc/hosts.orig ]; then 
  cp /etc/hosts /etc/hosts.orig
fi

# remove my fqdn from /etc/hosts
sed -i '/'${hostname_fqdn}'/d' /etc/hosts

# remove existing host ips from /etc/hosts
for i in `cat /tmp/etc_hosts | awk '{print $1;}'`; do 
  sed -i '/^'${i}' /d' /etc/hosts
done

# overwrite 
cat /tmp/etc_hosts | tee -a /etc/hosts

set +e
if [ -e "/etc/cloud/templates/hosts.redhat.tmpl" ]; then
  sed -i '/{{fqdn}}/d' /etc/cloud/templates/hosts.redhat.tmpl
  sed -i '/'${hostname_fqdn}'/d' /etc/cloud/templates/hosts.redhat.tmpl

  for i in `cat /tmp/etc_hosts | awk '{print $1;}'`; do 
    sed -i '/^'$i' /d' /etc/cloud/templates/hosts.redhat.tmpl; 
  done

  cat /tmp/etc_hosts | tee -a /etc/cloud/templates/hosts.redhat.tmpl
fi