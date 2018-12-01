# Scalable Data Processing for Retail

## Setup

Setup a VirtualBox with Ubuntu per class instruction video:
* Linux 64-bit system
* 8mb of RAM
* 20 GB hardrive space
* Ubuntu-18.04.1-desktop-amd64.iso(1.82GB)
* Computername:516
* Username:student

Execute

```bash
$ sudo apt-get install git
$ mkdir project
$ cd project
$ sudo apt-get install git
$ git clone https://github.com/cloudmesh-community/fa18-516-17.git
$ cd ~/project/fa18-516-17/project-code
$ sudo sh setup-1.sh
```

Wait until processing finishes then:

```bash
# RESTART THE VIRTUALBOX
$ sudo adduser --ingroup hadoop_group hduser
# Enter the Unix password "projectpass"
# Enter multiple times for default; then Y
$ sudo adduser hduser sudo
$ ssh-keygen -t rsa
# File in which to save the key: "hadkey"
# Enter 2x to create password. IN general this is not a good idea, but for this case we make an exception.
$ sudo su - hduser
$ sudo /bin/bash /home/student/project/fa18-516-17/project-code/setup-2.sh

```

Wait until processing finishes then:

```bash
# From the hive> prompt create the table by copying in the following:
CREATE EXTERNAL TABLE IF NOT EXISTS retaildata(Period_Key INT, Item_Key INT, Store_Key INT, POSQty INT, POSSales DOUBLE, Demand_Dollars DOUBLE) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE LOCATION '/home/hduser/cloudmesh/retailhdfs/hivedbtable.txt' TBLPROPERTIES("skip.header.line.count"="1");

# From the hive> prompt create the table by copying in the following:

load data local inpath '/home/hduser/cloudmesh/retailhdfs/retaildata2.txt' into table retaildata;

# Control C to exit Hive
$ sudo sh /home/student/project/fa18-516-17/project-code/setup-3.sh

```

Wait until processing finishes then:

```bash
## Test
#Hive Server2 start
$HIVE_HOME/bin/hiveserver2

#In a NEW TERMINAL

cd ~
$python remote.py

#This should kick off a query tht runs on HIVE to calculate the average price by item
```

