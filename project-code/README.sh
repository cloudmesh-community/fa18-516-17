# wget https://raw.githubusercontent.com/cloudmesh-community/fa18-516-17/master/project-code/README.sh
# bash README.sh

sudo apt-get install git-core

wget https://raw.githubusercontent.com/cloudmesh-community/fa18-516-17/master/project-code/bashrc-add

wget https://raw.githubusercontent.com/cloudmesh-community/fa18-516-17/master/project-code/pyenv-setup.sh

bash python-setup.sh
cat bashrc-add >> .bashrc
