# Scalable Data Processing for Retail :hand: fa18-516-17

| Brad Pope
| popebradleyt@gmail.com
| Indiana University
| hid: fa18-516-17
| github: [:cloud:](https://github.com/cloudmesh-community/fa18-516-17/blob/master/project-paper/report.md)
| code: [:cloud:](https://github.com/cloudmesh-community/fa18-516-17/blob/master/project-code/README.sh)

**:mortar_board: Learning Objectives**


* Describe the unique data storage and compute needs of the Retail Industry
* Implement portions of a cloud computing environment that would meet those needs
* Describe the performance of the prescribed cloud computing environment on a sample retail dataset
* Highlight some additional architecture opportunities outside the scope of this project that would further help the Retail sector


---

Keywords: Hadoop, Hive, WebHCat, Java, Retail

---

## Introduction


As with other industries, the retail industry today is undergoing a major shift.  Traditional brick and mortar stores used to relay on practiced merchandising techniques such as printed flyers, television advertising and low prices to drive traffic into stores.  Today, shoppers are electing for convenience more than ever before.  This is driving growth in a variety of time-saving Omni channel purchasing behaviors.  Shoppers are voting with their wallets for more product being shipped to their door or to their cars with grocery pick-up.
In tandem with a more demanding shopper there is also a fundamental shift in the sheer amount of data collected on the path taken to purchase products.  From the interaction to advertising campaigns, social media impact through research done online vs in-store, there is more data than ever available for retailers to leverage.  
To survive, Retailers need to be open to change and use every advantage they have.  A fundamental element of developing their strategy is having a saleable cloud architecture to leverage the masses of data that they should be collecting about their shoppers.  The challenge is that as technology has evolved each retailer responded differently and implemented a piecemeal data strategy to accommodate data as it becomes available.  The challenge is to offer a cloud based highly scalable distributed architecture that will allow retailers to process the data a variety and integrate new data sets as they become available.

## Dataset
In order to appreciate the storage and computational requirements it is important to understand the idiosyncrasies of a retail data set.  I’ll describe the basics here before I describe the subset I chose for this project.
Data available to retailers is heavily nuanced as each retailer collects and houses data in a different way.  There are a host of internal metrics required in the ordinary course of business.  In addition, there are a mounting number of external datasets now required to effectively compete.  All of this makes for a challenge when it comes to acquiring, blending and putting the data to use.  
Retailer generated data (Internal data): This is data that the retailer creates during the normal course of business.  This includes transactional data such as what product was sold in each store at any given time including what other products it sold with in a specific transaction.   At an operational level it includes the purchase orders they uses to get more product to sell from suppliers, inventory levels in warehouses and stores.  Operational data is also future looking with anticipated through merchandise forecasts.  There are other data sets that track what products should be on shelves, how much product should be there and where the product should go.  In short, there is complexity for Retailers on their internal data sets range greatly in terms their uses and the metrics gathered.  
*	Granularity describes the level of depth of a dataset.  On one side of the scale transactional data sets are at a shopper, store, item, date/timestamp level of granularity and include important features such as what products are purchased together.  Commonly retailers make operational available at the store, product, day or week levels of granularity.  For example, units per store per day is a normalized measure of how quickly a product sells in a given store set.
*	Frequency describes how often a dataset is refreshed.  Some measures are importation operationally and refreshed continually.  Other datasets are more static and refreshed weekly such as forecasts monthly for reference information like competitive stores or annually for datasets like exchange rates used for planning purposes.
*	Latency describes how much of a lag exists with a data set.  For example, while a dataset may be updated daily it may have two or three-day latency for the data to get from the stores where the product is selling to flow into the central repository.
*	Restatement or trickle data occurs when updated data becomes available for past time periods.  When this occurs processes need to be in place to remove previous data with the updated numbers.  Controls or versions of data should be in place for critical numbers such as actual sales where get reported to shareholders.
Externally generated data: Not all data that a retailer uses comes from their internally systems as it gives partial insight to shoppers and competitors.  To supplement internal data retailers are continually assessing shopper preferences.  In order to do this many subscribe to services offered by IRI, Nielsen and/or InfoScout.  This type of data allows them to understand who their shoppers are and if they are getting their fair “share of wallet” or percent of purchases of each category were made in their locations.  It also allows them to see what other products those shoppers buy and which of their competitors those shoppers are purchasing them.  
There are several external sources of data that have recently entered the market.  
*	Social Media: Insights from Social media have become highly sought in recent years making that a highly coveted dataset.  
*	Omnichannel: Omnichannel and path to purchase data varies greatly and can holds insights as to how consumers shop for certain products and brands.  
*	Ecommerce: Purchases made on-line is also a desirable subset of the data. Ecommerce continues to pull purchases away from traditional retailers and understanding which products have better potential to sell on-line is considered essential
The complexity with this data is that it can be hard to combine and mine with a retailers internal transactional and operational data.  
### Project dataset.  For this project I chose a very common metric set and masked the data so the proprietary retailer and supplier are unrecognizable:
*	Store – This column represents a single store.   The number of stores varies greatly by retailer.  In our dataset I included 300 stores.  Larger retailer chains can have more than 10,000 stores internationally.
*	Product – This is a proxy for a product UPC or Item Number.  Retailers will sell thousands of products in any given retail location.  For our purposes here 23 products were included.
*	Period_Key – Date information in a YYYYMMDD format.  Many retailer datasets have two years of history available.  This dataset contains daily data from 10/23/2015 through 10/15/2017 which equates to 723 unique dates.
*	Sales Dollars – Dollar value associated for each product, store and period
*	Sales Units – Number of units sold for each product, store and period
*	Potential Demand – potential revenue associated with having the product available for sale (no out of stocks).  This is illustrative of a calculated metric calculated from existing metrics


## Implementation
For this project I chose to implement a Hadoop based solution shown in the diagram below.  
While a learning exercise there were reasons behind the selection of the components:
### Hadoop 
I chose to use Apache Hadoop for retailers for several reasons.  First, the benefits Hadoop is capable of are well aligned with the needs of retailers.  According to the home page of the Hadoop project at Apache Software Foundation, "Apache Hadoop offers highly reliable, scalable, distributed processing of large data sets using simple programming models. With the ability to be built on clusters of commodity computers, Hadoop provides a cost-effective solution for storing and processing structured, semi- and unstructured data with no format requirements." [@Misc{fa18-516-17-Hadoop].  

First and foremost, the cost advantages associated with open source software should not be overlooked.  Retailers working with razor thin margins are not only battling their on-line coutnerparts, there are a host of aggressive discount retailers such as Aldi, Family Dollar and Lidl that have been aggressively attacking with low cost private label product.  Saving money on operations for retailers is critical to maintain a margin.

From a retailer standpoint this is a good choice since it can reliably process for a range of data needs, and distribute them in a scalable way.  Operation data is the lifeblood of a retailer.  If the computer assisted order system does not know the inventory and sales from a store as well as the future forecast it will not be able to issue purchase orders to suppliers and keep product on stores for ongoing business. Rather than relying on the hardware to rely on redundancy and high-availability, Hadoop detects and handles failures at the application layer.  This delivers a high-availability service on top of a cluster of computers which could individually fail. [@Misc{fa18-516-17-highavailablity]

The application layer also allows for adding more datasets as they become available which is a key retailer need.  The Hadoop framework scales from processing on a single server to thousands of machines and uses the computation and storage available on each.  As new formats of semi and unstructured data become available 

New data formats in semi- and unstructured formats such as social media, shopper sentiment can be handled by Hadoop as well.  Traditional Enterprise Data Warehouse (EDW) would struggle with that integration. This data when coupled with the other operational data and help provide more accurate analytic decisions retailers need. [@Misc{fa18-516-17-Hadoop]
 
### Linux
I choose to install Hadoop on a Linux VirtualBox.  While Hadoop can be installed on Windows, Unix and Mac OS X there is an informal consensus on the internet that if you want to run production Hadoop with the fewest number of issues it is best to use Linux.  
### HDFS
Next I chose to use the native distributed file system for Hadoop to setup a distribute storage platform and integrate it with other computational platforms. The Hadoop Distributed File system (HDFS) is Hadoop's way of proven ability to store very large files on a cluster of commodity hardware. [@Misc{fa18-516-17-commodityhardware]

For a retailer with thousands of stores and thousands of products capturing all of the data necessary results in petabytes of data.  In addition, data is constantly being created as products move in the supply chain, sell in the stores and forecasting and planning are continually being done in the background.  HDFS accommodates these demands with the way it is designed.
First, it is possible to store files of any size on HDFS.  The distributed file system breaks files down to files that potentially petabytes in size into smaller pieces or blocks and each piece could be stored on a different machine. In this system a HDFS master node is known as a NameNode and a slave node is called a DataNode. NameNodes maintain and manage all information about all files and directories stored on HDFS including the file system tree and metadata. DataNodes are the actual storage for the blocks. NameNode sends blocks to the DataNodes to store and DataNodes continuously report their status back including the list of blocks they are storing.  This makes it possible to store files of any size on a Hadoop Cluster.
For the purposes of the project I’m keeping the NameNode and the DataNode on the same VirtualBox with a small set of sample data, in order to do this at scale leveraging the HDFS structure using NameNodes and DataNodes distributed across many servers would be required.  In addition, to fully leverage HDFS the goal would be to store the retailer data in larger files instead of millions of smaller files to be able to have the NameNode use less memory.
Commodity Hardware means using standard commonly used hardware without the need to specialized high-end systems. Being able to use more common server configuration systems to build a reliable cluster with HDFS results in saving money which is extremely important to this demographic.

