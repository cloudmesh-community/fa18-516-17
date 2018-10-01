The project concept is to pull product, review and selling data off of Amazon Product Advertising and look for opportunities to sell more products.

Amazon Web Services (AWS) is a platform discouraged by Retailers and hence not used by many Consumer Packaged Goods companies.  Project infrastructure revolves around using a non-AWS stack to pull Amazon items and reviews for analysis purposes.  It allows an individual to enter a set of product UPCs and understand where their opportunities are.

Potential steps:
	1) Interact with Amazon Product Advertising API
		a. Amazon has web service that millions of customers use every day
		b. Build Product Advertising API applications that leverage this robust, scalable, and reliable technology. 
		c. Fields to retrieve:
			i. items for sale
			ii. customer reviews
			iii. seller reviews
			iv. customer reviews
			v. product promotions
	2) Setup and Azure environment
		a. UI that allows users to enter in their product code / UPCs
		b. Database to store items from Amazon (maybe Apache Hive but I'm open to others)
		c. Calls to get the data from Amazon's API
	3) Identify products that have opportunities.  
		a. Poor descriptions or poor reviews
			i. Simple comparison if time is scarce
			ii. If time allows and the data is robust I'd like to try using ML with spark
			i. Training: Compare seller and customer reviews to actual sales if it exists
ii. Testing: Take the model that performs the best in test and apply it to data available from Amazon Product Advertising API
