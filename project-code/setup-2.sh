#Install Java

# Create directory and navigate to it
mkdir -p ~/cloudmesh/bin
cd ~/cloudmesh/bin

# Get file and sign user agreement
wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.tar.gz"

# Run Java Tarball
tar -xzvf jdk-8u191-linux-x64.tar.gz

# Install hadoop

cd ~/cloudmesh/bin/

wget http://mirrors.sonic.net/apache/hadoop/common/hadoop-3.1.1/hadoop-3.1.1.tar.gz

# Run hadoop tarball
tar -xzvf hadoop-3.1.1.tar.gz

#Update export paths for current and future installs

gedit ~/.bashrc

#at the bottom of the .bashrc file make the following exports then save the file
export JAVA_HOME=~/cloudmesh/bin/jdk1.8.0_191
export HADOOP_HOME=~/cloudmesh/bin/hadoop-3.1.1
export YARN_HOME=$HADOOP_HOME
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export PATH=$HADOOP_HOME/bin:$JAVA_HOME/bin:$PATH
export HIVE_HOME=/home/hduser/cloudmesh/apache-hive-3.1.1-bin
export TEMPLETON_HOME=~/cloudmesh/apache-hive-3.1.1-bin/hcatalog
export HCATALOG_HOME=~/cloudmesh/apache-hive-3.1.1-bin/hcatalog
export PATH=$PATH:$HIVE_HOME/bin:$TEMPLETON_HOME/bin


source ~/.bashrc
java -version

"""If you have installed things properly there will be no errors. It will show the version as follows,

java version "1.8.0_191"
Java(TM) SE Runtime Environment (build 1.8.0_191-b12)
Java HotSpot(TM) 64-Bit Server VM (build 25.191-b12, mixed mode)
"""

#Verify the hadoop installation:

hadoop

# getting the retail data file

cd ~

curl -L "https://drive.google.com/uc?export=download&id=150QG8juv9Vo29lkJIqhMLVQmLsIjXKzJ" >retaildata2.txt


#Get to the right directory
cd /home/hduser/cloudmesh/bin/hadoop-3.1.1/sbin/

#Format the name node
hadoop namenode -format

# remove this if it works.  https://stackoverflow.com/questions/8076439/namenode-not-getting-started
./start-all.sh  

cd ~/cloudmesh
hdfs dfs -mkdir retailhdfs

# copy the file in using HDFS
hdfs dfs -put /home/hduser/retaildata2.txt retailhdfs

#check to make sure the retaildata2.txt file makes it to the cloudmesh/retailhdfs folder in under the hdfs system
hdfs dfs -ls retailhdfs

# HIVE
# Note the export paths have already been included in the bashrc earlier

# Get Hive
# From cloudmesh directory:
wget http://apache.claz.org/hive/hive-3.1.1/apache-hive-3.1.1-bin.tar.gz

#Extracting hive
tar -xvzf apache-hive-3.1.1-bin.tar.gz

#double check if Hive home is there
echo $HIVE_HOME 

cd ~/cloudmesh/apache-hive-3.1.1-bin/conf
sudo gedit hive-env.sh.template

#Edit the file to the following 
# Set HADOOP_HOME to point to a specific hadoop install directory
HADOOP_HOME=/home/hduser/cloudmesh/bin/hadoop-3.1.1

# Hive Configuration Directory can be controlled by:
export HIVE_CONF_DIR=/home/hduser/cloudmesh/apache-hive-3.1.1-bin

cd ~/cloudmesh

hdfs dfs -mkdir tmp


hdfs dfs -chmod g+w retailhdfs
hdfs dfs -chmod g+w tmp


#Check hive version
hive --version
