# Master install script from class
# THIS SCRIPT WILL DESTROY YORU .bashrc FILE IF YOU EXECUTE IT TWICE
#

# put your script here, ENV2 and ENV3 must be avialable, and bashrc
# must be updated. avoid updating bashrc twice, a student did this
# yesterday, so if pyenv is already in there you can not cincatenate

sudo apt-get update -y
sudo apt-get install -y apt-utils
sudo apt-get install -y build-essential libssl-dev
sudo apt-get install -y rsync
sudo apt-get install -y wget
sudo apt-get install -y curl
sudo apt-get install -y git-core
sudo apt-get install -y dnsutils
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev
sudo apt-get install -y libreadline-dev libsqlite3-dev llvm libncurses5-dev
sudo apt-get install -y emacs
sudo apt-get install ssh
# installed ssh as it is a hadoop prereq

wget -q https://raw.githubusercontent.com/cloudmesh-community/images/master/pyenv/bash_rc_add.sh
curl -s -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

#
# this has a bug and shoudl not be executed more than once
#
echo 'export PYENV_ROOT=$HOME/.pyenv' >> ~/.bashrc
echo 'export PATH=$PYENV_ROOT/bin:$PATH' >> ~/.bashrc
cat bash_rc_add.sh >>  ~/.bashrc

PYENV_ROOT=$HOME/.pyenv
PATH=$PYENV_ROOT/bin:$PATH

pyenv update
pyenv install 3.7.1
pyenv install 2.7.15
pyenv virtualenv 2.7.15 ENV2
pyenv virtualenv 3.7.1 ENV3

echo "ENV3" >> ~/.bashrc

sudo addgroup hadoop_group
