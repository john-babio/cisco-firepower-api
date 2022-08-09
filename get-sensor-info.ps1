#[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
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
$acctname = "***username***"
$password = "****password***"
$server = "***PUT IP HERE***"
$domain = "***PUT DOMAIN HERE***"
$auth = Invoke-WebRequest -Method POST  "https://$server/api/fmc_platform/v1/auth/generatetoken" -Header @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($acctname):$($password)"));}
$authkey = $auth.Headers.'X-auth-access-token'

$apipath = "/api/fmc_config/v1/domain/$domain/devices/devicerecords?limit=300&expanded=true"

$network = Invoke-RestMethod -Method GET -ContentType 'application/json' "https://$server/$apipath" -Header @{'X-auth-access-token' = "$authkey"} 

$network.items | select name, model, hostName, sw_version, HealthStatus  
# $network.items | select name, model, hostName, sw_version, HealthStatus | where-object { $_.Model -match "ASA5508" } //Matches Model firewalls 5508
# $network.items | select name, model, hostName, sw_version, HealthStatus | where-object { $_.sw_version -notmatch "6.6.7" } //Matches everything but 6.6.7 software
# $network.items | select name, model, hostName, sw_version, HealthStatus | where-object { $_.HealthStatus -notmatch "green" } //non healthy firewall or firewall modules
