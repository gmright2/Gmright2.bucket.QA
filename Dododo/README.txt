INTRODUCTION
============
This SoapUI Sample Project file is for eBay Listing Recommendation Services API and can be used to test the API requests and responses via SoapUI tool.
REF : http://developer.ebay.com/Devzone/listing-recommendation/index.html

The sample project file covers all supported Listing Recommendation Services API calls. Since this API is a rest based service, we recoomend that you
have the latest version of the SOAP UI that supports REST Testing

INSTRUCTIONS
=============

Instructions for setting up and configuring SoapUI :
1. Download the "ListingRecommendationServicesAPI_SOAPUI_Sample_Project.xml" project file.
2. Download soapUI from http://www.soapui.org and install it.
3. In the File menu, select 'Import Project' and import the "ListingRecommendationServicesAPI_SOAPUI_Sample_Project.xml" file.
4. After the project is loaded, expand the project tree and select an API call.
5. Enter your 'user Token' for the Authorization header in the format 'TOKEN UserToken'.
For Required Http Headers, see here : developer.ebay.com/Devzone/listing-recommendation/Concepts/MakingACall.html#CallStructure
6. Run the test.

Note: For the API 'itemRecommendations', you will notice that there is an Item in the call endpoint i.e
      https://svcs.ebay.com/services/selling/listingrecommendation/v1/item/300878655630/itemRecommendations.
      So in the SOAPUI, double click this API, it will open the 'Resource' window and let you edit the URL. Please replace the default
      ItemID with the one that you want the recommendations for.
