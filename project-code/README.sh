# setup pyenv

wget https://raw.githubusercontent.com/cloudmesh-community/fa18-516-17/master/project-code/pyenv-setup.sh

sh pyenv-setup.sh

restart the virtualbox


11.2.6 Installation of Hadoop  https://github.com/cloudmesh-community/book/edit/master/chapters/mapreduce/hadoop-installation.md

11.2.6.1 Prerequisites

sudo apt-get install ssh
sudo apt-get install rsync
sudo apt-get install emacs

11.2.6.2 User and User Group Creation

For security reasons we will install hadoop in a particular user and user group. We will use the following

sudo addgroup hadoop_group
sudo adduser --ingroup hadoop_group hduser
sudo adduser hduser sudo
#These steps will provide sudo privileges to the created hduser user and add the user to the group hadoop_group.

11.2.6.3 Configuring SSH

#Here we configure SSH key for the local user to install hadoop with a ssh-key. This is different from the ssh-key you used for Github, FutureSystems, etc. Follow this section to configure it for Hadoop installation.

The ssh content is included here because, we are making a ssh key for this specific user. Next, we have to configure ssh to be used by the hadoop user.

sudo su - hduser

ssh-keygen -t rsa

# Follow the instructions as provided in the commandline. When you see the following console input, press ENTER. Here only we will create password less keys. IN general this is not a good idea, but for this case we make an exception.

#Enter file in which to save the key (/home/hduser/.ssh/id_rsa):

hadkey




JAVA

11.2.6.4 Installation of Java

# If you are already logged into su, you can skip the next command.  If not:

sudo su - hduser

# control D gets you out! (maybe exit too)

Go to here to accept the agreement
https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html

Now execute the following commands to download and install java

mkdir -p ~/cloudmesh/bin
cd ~/cloudmesh/bin


wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.tar.gz"


tar -xzvf jdk-8u191-linux-x64.tar.gz


# 11.2.6.5 Installation of Hadoop from 

cd ~/cloudmesh/bin/

wget http://mirrors.sonic.net/apache/hadoop/common/hadoop-3.1.1/hadoop-3.1.1.tar.gz
tar -xzvf hadoop-3.1.1.tar.gz


11.2.6.6 Hadoop Environment Variables

In Ubuntu the environmental variables are setup in a file called bashrc at it can be accessed the following way

emacs ~/.bashrc

export JAVA_HOME=~/cloudmesh/bin/jdk1.8.0_191
export HADOOP_HOME=~/cloudmesh/bin/hadoop-3.1.1
export YARN_HOME=$HADOOP_HOME
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export PATH=$HADOOP_HOME/bin:$JAVA_HOME/bin:$PATH
export HIVE_HOME=/home/hduser/cloudmesh/apache-hive-3.1.1-bin
export TEMPLETON_HOME=~/cloudmesh/apache-hive-3.1.1-bin/hcatalog
export HCATALOG_HOME=~/cloudmesh/apache-hive-3.1.1-bin/hcatalog
export PATH=$PATH:$HIVE_HOME/bin:$TEMPLETON_HOME/bin


In Emacs to save the file Ctrl-X-S and Ctrl-X-C to exit. After editing you must update the variables in the system.

source ~/.bashrc
java -version

"""If you have installed things properly there will be no errors. It will show the version as follows,

java version "1.8.0_191"
Java(TM) SE Runtime Environment (build 1.8.0_191-b12)
Java HotSpot(TM) 64-Bit Server VM (build 25.191-b12, mixed mode)

And verifying the hadoop installation,"""

$ hadoop


# getting the file

cd ~

curl -L "https://drive.google.com/uc?export=download&id=150QG8juv9Vo29lkJIqhMLVQmLsIjXKzJ" >retaildata2.txt

# logs you in as hduser
sudo su - hduser


#Get to the right directory
cd /home/hduser/cloudmesh/bin/hadoop-3.1.1/sbin/

#Formatting the name node
hadoop namenode -format

"""
https://stackoverflow.com/questions/8076439/namenode-not-getting-started
./start-all.sh  #can't remember if I run this
"""

# http://fibrevillage.com/storage/630-using-hdfs-command-line-to-manage-files-and-directories-on-hadoop

cd ~
cd cloudmesh
# $ hdfs dfs -mkdir <paths>
hdfs dfs -mkdir testhdfs
#hdfs dfs -put <localsrc> ... <HDFS_dest_Path>
# copy the file in using HDFS
hdfs dfs -put /home/btpope/retaildata2.txt testhdfs
#check to make sure the file makes it in under the hdfs system

cd ~
cd cloudmesh

hdfs dfs -ls testhdfs

# HIVE.  Note the export paths have already been included in the bashrc earlier
# Get Hive

# From cloudmesh directory:
wget http://apache.claz.org/hive/hive-3.1.1/apache-hive-3.1.1-bin.tar.gz

#Extracting it
tar -xvzf apache-hive-3.1.1-bin.tar.gz

#check if Hive home is there
echo $HIVE_HOME 



cd ~
cd cloudmesh/apache-hive-3.1.1-bin/conf
sudo gedit hive-env.sh.template

!!!!Keep going: https://www.edureka.co/blog/apache-hive-installation-on-ubuntu

# Steps 5 and 6:

cd ~
cd cloudmesh

hdfs dfs -mkdir tmp
# we made the temp directory above.  Consider moving it




cd ~
cd cloudmesh


hdfs dfs -chmod g+w testhdfs
hdfs dfs -chmod g+w tmp


#Edit the file to the following 
# Set HADOOP_HOME to point to a specific hadoop install directory
HADOOP_HOME=/home/hduser/cloudmesh/bin/hadoop-3.1.1

# Hive Configuration Directory can be controlled by:
export HIVE_CONF_DIR=/home/hduser/cloudmesh/apache-hive-3.1.1-bin

SAVE THE FILE in the same directory WITHOUT ".terminal" at the end

#Check hive version
hive --version


#Step 8: Create hive-site.xml not sure how to edit this… many references to the DB

cd ~
cd cloudmesh/apache-hive-3.1.1-bin/conf
gedit hive-site.xml


