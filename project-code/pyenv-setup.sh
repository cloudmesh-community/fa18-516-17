# wget https://raw.githubusercontent.com/cloudmesh-community/fa18-516-17/master/project-code/pyenv-setup.sh
# bash python-setup.sh

sudo apt-get update
sudo apt-get install -y git-core

sudo apt-get install -y python-pip 
sudo apt-get install -y make build-essential libssl-dev
sudo apt-get install -y zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev
sudo pip install virtualenvwrapper


git clone https://github.com/yyuu/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv   
git clone https://github.com/yyuu/pyenv-virtualenvwrapper.git ~/.pyenv/plugins/pyenv-virtualenvwrapper

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc

sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev git

pip install --upgrade pip

wget https://raw.githubusercontent.com/cloudmesh-community/fa18-516-17/master/project-code/bashrc-add

source .bashrc

which pyenv

pyenv install -l

pyenv update
pyenv install 2.7.15
pyenv install 3.7.0

pyenv global 3.7.0

pyenv version

pyenv versions

pyenv virtualenv 2.7.15 ENV2
pyenv virtualenv 3.7.0 ENV3

cat bashrc-add >> .bashrc
source .bashrc
