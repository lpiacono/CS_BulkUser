<# 

Script: Bulk Add User Script to CS Falcon Platform
Version: 0.1
Author: leandro.iacono@crowdstrike.com

**************DISCLAIMER**************

This sample scripts is not supported under any CrowdStrike standard support program or service. 

This sample script is provided AS IS without warranty of any kind. 

CrowdStrike further disclaims all implied warranties including, without limitation, any implied warranties of merchantability
or of fitness for a particular purpose. The entire risk arising out of the use or performance of the sample scripts and 
documentation remains with you. In no event shall CrowdStrike, its authors, or anyone else involved in the creation, production, 
or delivery of the script/s be liable for any damages whatsoever (including, without limitation, damages for loss of business profits, 
business interruption, loss of business information, or other pecuniary loss) arising out of the use of or inability to use the 
sample scripts or documentation, even if CrowdStrike has been advised of the possibility of such damages.

*********END OF DISCLAIMER************

#>

#Load Config File (JSON)
$config = Get-Content -Path .\config.json -Raw | ConvertFrom-Json

$c_id = $config.ClientID
$c_se = $config.ClientSecret
$roles = $config.Roles
$filepath = $config.Email_File

<# Older Read-Host Values replaced with JSON Config File
$c_id = Read-Host -Prompt "ClientID“
$c_se = Read-Host -Prompt "ClientSecret"
$roles = Read-Host -Prompt 'Falcon Roles to Assign'
$filepath = Read-Host -Prompt 'Path to File with Email Addresses'
#>

#Setup Empty Array
$params = @{
    Uri = ""
    Headers = @{'Authorization' = ""}
    Method = ""
    Body = ""
    ContentType = ""
}

#Fill Array to get OAuth Token
$params.Uri = 'https://api.crowdstrike.com/oauth2/token'
$params.Method = 'POST'
$params.Body ="client_id=“ + $c_id + “&client_secret=“ + $c_se
$params.ContentType = 'application/x-www-form-urlencoded'

#Execute OAuth Token
$r1 = Invoke-RestMethod @params
#$r1 | ConvertTo-Json

#Extract Token for Later Use
$token = $r1.access_token

#Load Email File
$file = Get-Content -Path $filepath

Write-Host -BackgroundColor Yellow -ForegroundColor Black "`n Do the following Email Addresses Look Good? `n"
Write-Host $file
Write-Host ""
$confirm = Read-Host -Prompt "[Y/N]"

if ($confirm -eq "Y" -or $confirm -eq "y")
    {
        #Loop Email List and Add Each Email with specified roles
        ForEach ($email in $file) 
            {

                $params.Uri = 'https://api.crowdstrike.com/users/entities/users/v1'
                $params.Headers.Authorization = "Bearer $token"
                $params.Body = ”{`”uid`":`"" + $email + "`"}”
                $params.ContentType = 'application/json'

                $r2 = Invoke-RestMethod @params
                #$r2 | ConvertTo-Json

                $params.Uri = 'https://api.crowdstrike.com/user-roles/entities/user-roles/v1?user_uuid=' + $r2.resources.uuid 
                $params.Body = "{`"roleIds`": [" + $roles + "]}"

                $r3 = Invoke-RestMethod @params
                #$r3 | ConvertTo-Json

            }
        }
else
    {
    Write-Host -BackgroundColor Red -ForegroundColor Black "`n SCRIPT TERMINATED"
    }





