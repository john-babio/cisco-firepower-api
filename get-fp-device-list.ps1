add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
$acctname = "username"
$password = "password"
$server = "ip address of FMC"
#$domainuuid can be found by going to https://yourfmcip/api/api-explorer and running execute on any device HTTP Get request.
$domainuuid = "uuid of domain found in api explorer"
$auth = Invoke-WebRequest -Method POST  "https://$server/api/fmc_platform/v1/auth/generatetoken" -Header @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($acctname):$($password)"));}
$authkey = $auth.Headers.'X-auth-access-token'
$apipath = "/api/fmc_config/v1/domain/$domainuuid/devices/devicerecords?limit=300&expanded=true"
$network = Invoke-RestMethod -Method GET -ContentType 'application/json' "https://$server/$apipath" -Header @{'X-auth-access-token' = "$authkey"} 
$network.items 
