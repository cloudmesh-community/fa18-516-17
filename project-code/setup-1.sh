#! /bin/sh

# setup pyenv

wget https://raw.githubusercontent.com/cloudmesh-community/fa18-516-17/master/project-code/pyenv-setup.sh

sh pyenv-setup.sh

restart the virtualbox


# Hadoop  Installation 

# Prerequisites

sudo apt-get install ssh
sudo apt-get install rsync
sudo apt-get install emacs

# User and User Group Creation
# For security reasons we will install hadoop in a particular user and user group. We will use the following

sudo addgroup hadoop_group
sudo adduser --ingroup hadoop_group hduser
sudo adduser hduser sudo
#These steps will provide sudo privileges to the created hduser user and add the user to the group hadoop_group.

# Configuring SSH
#Here we configure SSH key for the local user to install hadoop with a ssh-key. This is different from the ssh-key you used for Github, FutureSystems, etc. Follow this section to configure it for Hadoop installation.

# The ssh content is included here because, we are making a ssh key for this specific user. Next, we have to configure ssh to be used by the hadoop user.

sudo su - hduser
ssh-keygen -t rsa

# Follow the instructions as provided in the commandline. When you see the following console input, press ENTER. Here only we will create password less keys. IN general this is not a good idea, but for this case we make an exception.

#Enter file in which to save the key (/home/hduser/.ssh/id_rsa):

hadkey


#Install Java

# If you are already logged into su, you can skip the next command.  If not:

sudo su - hduser

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

# If you are NOT logged in as hduser please do with this:
sudo su - hduser

#Get to the right directory
cd /home/hduser/cloudmesh/bin/hadoop-3.1.1/sbin/

#Format the name node
hadoop namenode -format

# remove this if it works.  https://stackoverflow.com/questions/8076439/namenode-not-getting-started
./start-all.sh  #can't remember if I run this


# remove this if it works. http://fibrevillage.com/storage/630-using-hdfs-command-line-to-manage-files-and-directories-on-hadoop

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


# Remove me !!!!Keep going: https://www.edureka.co/blog/apache-hive-installation-on-ubuntu

cd ~/cloudmesh/apache-hive-3.1.1-bin/conf
sudo gedit hive-env.sh.template

#Edit the file to the following 
# Set HADOOP_HOME to point to a specific hadoop install directory
HADOOP_HOME=/home/hduser/cloudmesh/bin/hadoop-3.1.1

# Hive Configuration Directory can be controlled by:
export HIVE_CONF_DIR=/home/hduser/cloudmesh/apache-hive-3.1.1-bin

SAVE AS - save it WITHOUT ".terminal" at the end in the same directory

cd ~/cloudmesh

hdfs dfs -mkdir tmp

# remove we made the temp directory above.  Consider moving it

hdfs dfs -chmod g+w retailhdfs
hdfs dfs -chmod g+w tmp


#Check hive version
hive --version


#Step 8: Create hive-site.xml not sure how to edit this… many references to the DB

cd ~/cloudmesh/apache-hive-3.1.1-bin/conf
gedit hive-site.xml

""" copy the following into the hive-site.xml file:
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?><!--
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements. See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to You under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->
<configuration>
<property>
<name>javax.jdo.option.ConnectionURL</name>
<value>jdbc:derby:;databaseName=/home/hduser/cloudmesh/apache-hive-3.1.1-bin/metastore_db;create=true</value>
<description>
JDBC connect string for a JDBC metastore.
To use SSL to encrypt/authenticate the connection, provide database-specific SSL flag in the connection URL.
For example, jdbc:postgresql://myhost/db?ssl=true for postgres database.
</description>
</property>
<property>
<name>hive.metastore.warehouse.dir</name>
<value>/home/hduser/cloudmesh/retailhdfs</value>
<description>location of default database for the warehouse</description>
</property>
<property>
<name>hive.metastore.uris</name>
<value/>
<description>Thrift URI for the remote metastore. Used by metastore client to connect to remote metastore.</description>
</property>
<property>
<name>javax.jdo.option.ConnectionDriverName</name>
<value>org.apache.derby.jdbc.EmbeddedDriver</value>
<description>Driver class name for a JDBC metastore</description>
</property>
<property>
<name>javax.jdo.PersistenceManagerFactoryClass</name>
<value>org.datanucleus.api.jdo.JDOPersistenceManagerFactory</value>
<description>class implementing the jdo persistence</description>
</property>
</configuration>
"""
#save the hive-site.xml

# Derby is built into HIVE - works the purposes of this project on a local machine

~/cloudmesh/apache-hive-3.1.1-bin/bin/schematool -initSchema -dbType derby


#from here ~/cloudmesh
cd ~/cloudmesh
hive

----  

# From the hive> prompt create the table

CREATE EXTERNAL TABLE IF NOT EXISTS retaildata(Period_Key INT, Item_Key INT, Store_Key INT, POSQty INT, POSSales DOUBLE, Demand_Dollars DOUBLE) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE LOCATION '/home/hduser/cloudmesh/retailhdfs/hivedbtable.txt' TBLPROPERTIES("skip.header.line.count"="1"); 

# From the hive> prompt Calculate Average Price 

Select Item_Key,(POSSales/POSQty) AS AverageRetail FROM (Select Item_Key, sum(POSSales) AS POSSales, sum(POSQty) AS POSQty From retaildata GROUP BY Item_Key) byitem ORDER BY Item_Key;
