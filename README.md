# SmartGas
## Vision
SmartGas is an iOS app that strives to provide quick, easy access to the cheapest gas nearby its users.  It's purpose is to provide car users quick and easy information about nearby gas stations and their prices, ultimately saving them time and money.
## Features
SmartGas currently allows users to search their location for cheap gas, as well as locations of their choosing.  Once a desired location is selected, directions are provided via Apple Maps.
## Architecture
<img width="1250" alt="Screen Shot 2020-10-23 at 1 43 16 AM" src="https://user-images.githubusercontent.com/38991941/96965142-47304c00-14d1-11eb-823f-dafefa2bad90.png">
When a user provides a location to search, SmartGas provides an HTTP request to YellowPages.com and parces its HTML content for gas stations in the given area.  Results are then sorted by lowest to highest prices, and returned to the user. The address of the selected station is then converted to coordinates and given to MapKit, which allows users to view directions to the location in Apple Maps.
### Framework
SmartGas was written in Swift using Xcode. We used CocoaPods to load AlamoFire (for HTML networking), Kanna (for HTML parsing), and Skeleton View (for the loading animation while scraping is occurring).
## Developer Guide
### Xcode
We created this project using Xcode 12.1, and it works with that version at the time of writing (12.1 is the most current version as of writing). To install the latest version of Xcode, simply install it from the App Store. To download a specific version, go to the Apple Developer website. For a tutorial on these two methods, follow this link: https://www.freecodecamp.org/news/how-to-download-and-install-xcode/
### YellowPagesScraper branch is the working branch
The YellowPagesScraper branch on this repository contains the functioning app.  The main branch is outdated.  We understand that this goes against common practice, but we did not have enough time to figure out how to rename branches, and we felt that we shouldn't overwrite the main branch without further research.
## Known bugs and limitations
Currently there are a number of known bugs and limitations in SmartGas:

* Only locations within the United States will yield results
* The keyboard does not ever disappear once a user interacts with the search bar. This blocks some of the results, but it's more of an annoyance than a debilitating problem to the average user. However, it does make the app much harder to use with Apple's built-in voiceover, so users that depend on voiceover may find the current version of SmartGas difficult to use.
* If a user selects a station, that station will stay gray until the user searches a new location
* Some of the UI elements do not properly format for small screens
* Not all of the gas stations offer price information, but they are still displayed at the bottom of the list with a price of "N/A"
* Once a user searches for a particular location, they cannot return to the results for their geolocation unless they search for their geolocation
* Because price is the only priority in the list, some top results are far away from the user (15 minutes or more)
* Some searches yield misleading results. For example, a search for "St Paul" gives the locations of gas stations in Texas instead of the more commonly expected and more populous St. Paul, MN (Simply adding state initials after the city name solves most of these issues, but not all users found this to be intuitive).
* There is currently no feature to sort results by distance instead of price

## Team members
This app was created by Team Deymis for Macalester Class Comp225. Its members are Emily Shang, Yuchen Dou, and Max Insolia.

## Acknowledgements
This app would not have been possible without the help and mentorship of Shilad Sen, Richard Tian, and the feedback and advice of the rest of Shilad's Software Design and Development class.

Thanks to the friends and family members of Team Deymis that helped in the testing of SmartGas.
