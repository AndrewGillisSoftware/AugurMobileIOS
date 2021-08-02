# AugurMobileIOS
 IOS development for Augur

## Installation Quick Rundown

1. Quick run down to get you started is get a mac and install Xcode make sure it’s running Big Sur. 
2. If you don’t have a mac use VMware and look up VMware Big Sur install. 
3. Once mac and Xcode is acquired pull my repo open Xcode and click on import project/open project. 
4. Select the Xcode project file. 
5. Once the project opens look up how to change developer group change it to your iCloud. 
6. Make one if you don’t have one. 
7. If you don’t have an iPhone congrats your ready to test on simulator by clicking the drop down of apple devices and selecting iPhone 12 then click the play arrow. 
8. If you an iPhone I highly recommend pairing it to the mac or VMware to be able to install the app look up Xcode deploy to iPhone. 
9. Once deployed your app may not open iPhone, DONT PANIC this is expected. 
10. Go to settings on your iPhone and click general -> device management-> your iCloud  it should ask if you want to allow developer click yes. 
11. Go back to the app. 
12. Congratulations you have now deployed the application. 
13. Note if this was on App Store it wouldn’t be this complicated.
14. App store instructions: TBD


Summary of the Project

My project was to create a native Augur IOS application as a proof of concept and explore native technology versus a dynamic application using flutter. My objectives were to Explore UI Development, API Consumption with the codable interface, Data persistence through IOS Core Data, and gamification design of the Augur repositories. All of these objectives have been explored and completed.

UI Development is the majority of the hard work put into this project and was critical to the design of this application. Using a prebuilt Apple Tabbed view I was able to easily generate a professional app design. For a brief overview of the design see this video (Professor Goggins Please Link the Demo Video Here). In each of the tabs, a table view with organized data pulled on tab opening from the persistent data store (Core Data) removed the need for login. No need for a login simplifies the app immensely and is a better design decision for this app of this nature. UI Design is based on great UI Design specifications laid out by apple https://developer.apple.com/design/human-interface-guidelines/. 

API consumption from Augur proved to be tricky as there is no single instance of Augur. In the settings tab, I was able to add an instance settings panel that allows the user to enter the URL of the instance they wish to use. The instance panel fixes the multiple instance issue but a framework for consuming from the Augur API was required. Essentially, I followed these steps, Run a Postman Request on the API endpoint I wish to consume from. Copy the returned Json. Paste the Json into this helpful website https://www.json4swift.com/ that automagically creates structs that follow the codable interface based on the Json provided. These structs allow for easy API calls in the application. When calling the Augur API, swift will fill these structs and pre-parse the Json. It is common to collect these Structs into a list and display them in a table view. When a user selects a cell of the table view, read the cell's data and make an API call based on the selected cell's data. This approach makes API consumption extremely easy and puts most of the complexity on the design and flow of the application. Focusing on the design will improve the user experience.

Data Persistence with Core Data in IOS is simple but still allows for complicated queries. I normally would not recommend core data for large-scale applications however this application is perfect for core data as only the pearl count (Explained Below) and the Augur Instance URL are needed to be persisted. Data persistence in IOS refers to having data stored when the application is closed and reopened or when the phone restarts. 

The gamification design of the Augur repositories is not implemented but the Basic UI design and concept is completed. The game portion of the app is based on the UI Design and analysis research found at this repository https://github.com/MALIBUSPIRIT/code-opener/blob/main/Design%20Update%202_1_21.pdf. My contribution to the game design is the main game loop and achievement metric design. The game loop is as follows. The user has a minimum set of pearls (Currency) which are used to invest into repositories and their metrics. Investing in a repository is a great way to introduce both utility and an element of fun. When a user invests in only the repositories they are actively using in their projects it essentially becomes a metric for their ability to pick healthy (Investing for) and or depreciating repositories (Investing against). The reason for the minimum number of pearls is to always allow the user to invest. Additional pearls are gained through successful predictions of healthy repositories. These pearls can then be reinvested or used to buy "prizes". These prizes could be badges, banners, cosmetics, etc. 

In conclusion, I believe a native IOS application had enough benefits and built-in features to warrant a full-fledged native Augur application instead of a generic flutter application. Although, a flutter application cuts down on developer time. Native applications yield a better user experience. 
