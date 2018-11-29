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
$ git clone https://github.com/cloudmesh-community/fa18-516-17.git
$ cd ~/project/fa18-516-17/project-code
$ sudo sh setup-1.sh
```

Then do 

```bash

Then do:
RESTART THE VIRTUALBOX
# Hadoop  Installation - User and User Group Creation
$ sudo adduser --ingroup hadoop_group hduser
use the password "projectpass"
"Enter" for default; then Y
#HERE ON AUTOMATIC
$ sudo adduser hduser sudo
# Configuring SSH
$ ssh-keygen -t rsa
# Enter file in which to save the key "hadkey"
# Enter 2x to create password. IN general this is not a good idea, but for this case we make an exception.
sudo sh /home/student/project/fa18-516-17/project-code/setup-2.sh

```

## Configuration

# From the hive> prompt create the table by copying in the following:
CREATE EXTERNAL TABLE IF NOT EXISTS retaildata(Period_Key INT, Item_Key INT, Store_Key INT, POSQty INT, POSSales DOUBLE, Demand_Dollars DOUBLE) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE LOCATION '/home/hduser/cloudmesh/retailhdfs/hivedbtable.txt' TBLPROPERTIES("skip.header.line.count"="1");
#setup-3 start
$ sudo sh /home/student/project/fa18-516-17/project-code/setup-3.sh


## Test

Execute
$python remote.py

#This should kick off a query tht runs on HIVE to calculate the average price by item
```bash
$ test.sh
```

