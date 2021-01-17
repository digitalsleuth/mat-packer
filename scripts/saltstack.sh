echo "==> Installing salt-common"

if [ "$DISTRO" == "bionic" ]; then
  number="18.04"
elif [ "$DISTRO" == "focal" ]; then
  number="20.04"
fi

apt-get install -y software-properties-common
wget -O /usr/local/bin/mat https://github.com/digitalsleuth/mat-cli/releases/latest/download/mat-cli-linux
chmod +x /usr/local/bin/mat
wget -O - https://repo.saltstack.com/py3/ubuntu/$number/amd64/3001/SALTSTACK-GPG-KEY.pub | apt-key add -
echo "deb [arch=amd64] http://repo.saltstack.com/py3/ubuntu/$number/amd64/3001 $DISTRO main" > /etc/apt/sources.list.d/saltstack.list
apt-get update
apt-get install -y salt-common

#echo "==> Basic salt-minion configuration"
#echo "mat_version: ${MAT_VERSION}" > /etc/salt/grains

sleep 60
