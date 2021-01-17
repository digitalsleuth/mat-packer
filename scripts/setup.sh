#!/bin/bash -eux

echo "==> Giving ${SSH_USERNAME} sudo powers"
echo "${SSH_USERNAME}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/mat
chmod 440 /etc/sudoers.d/mat

# Fix stdin not being a tty
if grep -q -E "^mesg n$" /root/.profile && sed -i "s/^mesg n$/tty -s \\&\\& mesg n/g" /root/.profile; then
  echo "==> Fixed stdin not being a tty."
fi

echo "==> Installing base requirements"
export DEBIAN_FRONTEND=noninteractive
apt-get -y -o "Dpkg::Options::=--force-confdef" -o "Dpkg::Options::=--force-confold" install wget gnupg
