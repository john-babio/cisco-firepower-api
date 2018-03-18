[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$acctname = " "
$password = " "
$server = " "
$domainuuid = " "
$auth = Invoke-WebRequest -Method POST  "https://$server/api/fmc_platform/v1/auth/generatetoken" -Header @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($acctname):$($password)"));}
$authkey = $auth.Headers.'X-auth-access-token'
$apipath = "/api/fmc_config/v1/domain/"$domainuuid"?limit=250"
$GetRequest = Invoke-RestMethod -Method GET -ContentType 'application/json' "https://$server/$apipath" -Header @{'X-auth-access-token' = "$authkey"}
$GetRequest.items.Name 
