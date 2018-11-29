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

# I cut out many sections here!
sudo cp /home/student/project/fa18-516-17/project-code/hive-env.sh /home/hduser/cloudmesh/bin/hadoop-3.1.1

cd ~/cloudmesh

hdfs dfs -mkdir tmp


hdfs dfs -chmod g+w retailhdfs
hdfs dfs -chmod g+w tmp
"""

#Check hive version
hive --version

# setup-2 end

#Step 8: Create hive-site.xml not sure how to edit this… many references to the DB

# I made several changes here - more code in original
cp /home/student/project/fa18-516-17/project-code/hive-site.xml ~/cloudmesh/apache-hive-3.1.1-bin/conf

#save the hive-site.xml

# Derby is built into HIVE - works the purposes of this project on a local machine

~/cloudmesh/apache-hive-3.1.1-bin/bin/schematool -initSchema -dbType derby


#from here ~/cloudmesh
cd ~/cloudmesh
hive
