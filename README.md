# IBM-Ready-App-for-Banking

##Overview

IBM Ready App for Banking is the third IBM Ready App released.  This Ready App seeks to maximize a financial institution's ability to address the mobile needs of current Small Business Owner account holders as well as attract prospects through personalized guidance to set and achieve the financial goals of the business. The IBM Ready App for Banking utilizes the MobileFirst Platform, Watson Tradeoff Analytics in Bluemix, Cloudant, and integrated iOS TouchID for security.

Once a user launches this Ready App, a native pop up screen will prompt the user to "Start Hatch in Demo Mode"

Press **Yes** to launch the demo. If **No** is pressed, the user will have to enter the following credentials to login to the app environment.

| Username | Password |
|----------|----------|
| user1   | password1 |

##Getting started

To get started you will need Xcode 6.3, the MobileFirst Platform (MFP) Studio v6.3 (or the MFP CLI v6.3), a BlueMix account and a GitHub id to checkout this source code.

Before you can compile and run the code, you will need to perform some external service setup first and update 2 configuration files.  First you'll need to log into BlueMix and create a Mobile Quality Assurance (MQA) service instance. You can name it whatever you like. Once you have the instance up and running, you need to get the application key for this instance.

With MQA up and running you'll need to update the HatchReadyApp/apps/Hatch/iphone/native/Hatch/Configuration/Config.plist file and enter the MQA application id so that when you run the application you can see all the session instances and all the logging occurring in MQA.

Next you'll need to go back to BlueMix and create a Cloudant service instance and create a new Cloudant database. Make sure to write down the Cloudant account (this actually matches the initial username), the Cloudant user name and password as well as the database name for the database you just created.

While your still in BlueMix, also create a Watson Tradeoff Analytics Service and write down the base url provided as well as the username and password you will need to access this service from the mobile app.

With these bits of information you should now be able to update the HatchReadyApp/server/java/resources/app.properties to provide the values for both the Cloudant service and the Watson service.

Now you should be ready to build the MobileFirst project in either MFP Studio or the MFP CLI and then run the Xcode application.

##Documentation
For access to the full documentation please visit http://lexdcy040194.ecloud.edst.ibm.com/hatch_1_0_0/home
