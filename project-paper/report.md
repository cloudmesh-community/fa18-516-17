# Amazon Review Opportunities :hand: fa18-516-17

| Brad Pope
| popebradleyt@gmail.com
| Indiana University
| hid: fa18-516-17
| github: [:cloud:](https://github.com/cloudmesh-community/fa18-516-17/blob/master/project-paper/report.md)
| code: [:cloud:](https://github.com/cloudmesh-community/fa18-516-17/blob/master/project-code/README.sh)

**:mortar_board: Learning Objectives**

* Understand how interact with Amazon Product information
* Pull relevant products and look for review opportunities
* Use Azure

---

Keywords: Amazon, Azure

---

## Introduction

Amazon Web Services (AWS) is a platform discouraged by Retailers and hence not used by many Consumer Packaged Goods companies.  Project infrastructure revolves around using a non-AWS stack to pull Amazon items and reviews for analysis purposes.  It allows an individual to enter a set of product UPCs and understand where their opportunities are.

In order to do this we need to pull product, review and selling data off of Amazon Product Advertising and look for opportunities to sell more products.

Potential steps:

## Interact with Amazon Product Advertising API

* Amazon has web service that millions of customers use every day
* Build Product Advertising API applications that leverage this robust, scalable, and reliable technology. 
* Fields to retrieve:
			i. items for sale
			ii. customer reviews
			iii. seller reviews
			iv. customer reviews
			v. product promotions
## Setup and Azure environment

* UI that allows users to enter in their product code / UPCs
* Database to store items from Amazon (maybe Apache Hive but I'm open to others)
* Calls to get the data from Amazon's API

## Identify products that have opportunities.  

* Poor descriptions or poor reviews
* Simple comparison if time is scarce
* If time allows and the data is robust I'd like to try using ML with spark
* - Training: Compare seller and customer reviews to actual sales if it exists
* - Testing: Take the model that performs the best in test and apply it to data available from Amazon Product Advertising API
