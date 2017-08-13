## cisco-firepower-api
Cisco Firepower API scripts for Cisco Firepower Manager 6.2.1
This script allows for multi object creation reading from the items.txt file. This is useful when you have many objects to create inside of 
Cisco Firepower manager. Just add your objects to the items.txt file and place it in the same folder you are running the python script.
Inside of the python Script Change:
## Line 8 to match the ip address of your firepower manager
## Line 10,13 to your username and password
## Line 44 "Domain_UUID". Add your Domain_UUID by grabbing this from https://firepowermanaderip/api/api-explorer firepowermanagerip being the ip address of your firepower manager and remove the quotes from the uuid before placing it inside the string.
