# SmartGas
## Vision:
SmartGas is an iOS app that strives to provide quick, easy access to the cheapest gas nearby its users.  It's purpose is to provide car users quick and easy information about nearby gas stations and their prices, ultimately saving them time and money.
## Features:
SmartGas currently allows users to search their location for cheap gas, as well as locations of their choosing.  Once a desired location is selected, directions are provided via Apple Maps.
## Architecture:
When a user provides a location to search, SmartGas provides an HTTP request to YellowPages.com and parces its HTML content for gas stations in the given area.  Results are then sorted by lowest to highest prices, and returned to the user. The address of the selected station is then converted to coordinates and given to MapKit, which allows users to view directions to the location in Apple Maps. 
