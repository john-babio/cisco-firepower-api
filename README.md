## Python Script : Firepower-Network-Object-Multipost.py 
Cisco Firepower API scripts for Cisco Firepower Manager 6.4.0.10
This script allows for multi object creation reading from the items.txt file. This is useful when you have many objects to create inside of 
Cisco Firepower manager. Just add your objects to the items.txt file and place it in the same folder you are running the python script.
Inside of the python Script Change:
## Line 8 to match the ip address of your firepower manager
## Line 10,13 to your username and password
## Line 44 "Domain_UUID". Add your Domain_UUID by grabbing this from https://firepowermanaderip/api/api-explorer firepowermanagerip being the ip address of your firepower manager and remove the quotes from the uuid before placing it inside the string.
------------------------------------------------------------------------------------------------------------------------------------------
## Powershell Script : get-fp-device-list.ps1 
This powershell script will give you a list of firepower devices attached to your FirePower Manager. Fill in the Username, password, servername, and domain uuid. You can retrieve the domain uuid by using the api-explorer page of your firepower manager.

## Powershell Script : fmc-packet-transfer.ps1 
This powershell script will change the packet transfer settings in FMC for all sensors. This is usefull if the packet capture after a snort signature is triggered is not needed. Fill in the Username, password, servername, and domain uuid. You can retrieve the domain uuid by using the api-explorer page of your firepower manager.
