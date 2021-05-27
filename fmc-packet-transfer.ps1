[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$acctname = "username"
$password = "password"
$server = "ip address of fmc"
$domainuuid = "uuid of domain found in api explorer"
$auth = Invoke-WebRequest -Method POST  "https://$server/api/fmc_platform/v1/auth/generatetoken" -Header @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($acctname):$($password)"));}
$authkey = $auth.Headers.'X-auth-access-token'

$apipath = "/api/fmc_config/v1/domain/$domainuuid/devices/devicerecords?expanded=true&limit=500"
$Get = Invoke-RestMethod -Method Get -ContentType 'application/json' "https://$server/$apipath" -Header @{'X-auth-access-token' = "$authkey"} 

foreach ($line in $Get.items.id) {
$apipath2 = "/api/fmc_config/v1/domain/$domainuuid/devices/devicerecords/$line"
$getfile = Invoke-RestMethod -Method Get -ContentType 'application/json' "https://$server/$apipath2" -Header @{'X-auth-access-token' = "$authkey"}
$name = $getfile.name
$packet = $getfile.prohibitPacketTransfer
Write-host "**********************************************************"
Write-host "Firewall Sensor name: $name"
Write-host "Firewall Sensor Packet transfer settings: $packet"
Write-host "Firewall Sensor UUID: $line"

$hostname = $getfile.hostName

if ($packet -ne "True" ) {
           Write-host "Altering Packet transfer settings" 
           Write-host "**********************************************************"
           Write-host "                                                          "
                    $data = @{
                    "id" = $line
                    "name" = $name
                    "type" = "Device"
                    "hostName" = $hostname 
                    "prohibitPacketTransfer" = "true"
                    }
                    $body = $data | ConvertTo-Json
                    $getfile2 = Invoke-RestMethod -Method Put -Body $body -ContentType 'application/json' "https://$server/$apipath2" -Header @{'X-auth-access-token' = "$authkey"}
                    }
           else{
           Write-host "Packet transfer settings already Changed. Moving Along..."
           Write-host "**********************************************************"
           Write-host "                                                         "
           }
}

