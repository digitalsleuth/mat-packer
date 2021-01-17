#!/bin/bash -eux

if [[ "$DESKTOP" =~ ^(true|yes|on|1|TRUE|YES|ON])$ ]]; then
  exit
fi

echo "==> Disk usage before minimization"
df -h

echo "==> Installed packages before cleanup"
dpkg --get-selections | grep -v deinstall

# Remove some packages to get a minimal install
echo "==> Removing all linux kernels except the currrent one"
dpkg --list | awk '{ print $2 }' | grep 'linux-image-3.*-generic' | grep -v $(uname -r) | xargs apt-get -y purge
echo "==> Removing linux source"
dpkg --list | awk '{ print $2 }' | grep linux-source | xargs apt-get -y purge

# Clean up the apt cache
echo "==> Autoremove packages"
apt-get -y autoremove --purge
echo "==> Autoclean"
apt-get -y autoclean
echo "==> Clean"
apt-get -y clean

echo "==> Removing APT files"
find /var/lib/apt -type f | xargs rm -f
echo "==> Removing caches"
find /var/cache -type f -exec rm -rf {} \;

echo "==> Disk usage after cleanup"
df -h
