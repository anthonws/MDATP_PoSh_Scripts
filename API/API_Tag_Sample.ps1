# THIS IS A SAMPLE SCRIPT
# PLEASE NOTE THAT I TAKE NO RESPONSIBILITY ON THE RESULTS THIS SCRIPT MIGHT YIELD
# YOU SHOULD TEST IT AND MAKE SURE IT FITS YOUR NEEDS 

# Author: Antonio Vasconcelos
# Twitter: anthonws
# Date/Version/Changelog: 
# 2020-01-25 - 1.0 - First release

# Objective:
# Script that adds a specified Tag to machines in MDATP
# Input is expected to be a CSV file with 2 columns, one with "Name" and the other with "Tag". Ther first line are the headers. Break line for each new entry.
# MachineId is obtained via the ComputerDnsName, which should equate to the Host name or FQDN, depending on the type of machine join (WORKGROUP, Domain, etc.)

$tenantId = '000000000000000000000' ### Paste your own tenant ID here
$appId = '000000000000000000000' ### Paste your own app ID here
$appSecret = '000000000000000000000' ### Paste your own app keys here

$resourceAppIdUri = 'https://api.securitycenter.windows.com'
$oAuthUri = "https://login.windows.net/$TenantId/oauth2/token"

$authBody = [Ordered] @{
    resource = "$resourceAppIdUri"
    client_id = "$appId"
    client_secret = "$appSecret"
    grant_type = 'client_credentials'
}

$authResponse = Invoke-RestMethod -Method Post -Uri $oAuthUri -Body $authBody -ErrorAction Stop
$token = $authResponse.access_token

# Store auth token into header for future use
$headers = @{ 
        'Content-Type' = 'application/json'
        Accept = 'application/json'
        Authorization = "Bearer $token"
    }

# Clean variables

$Data = @();
$MachineName = $null;
$MachineTag = $null;
$MachineId = $null;

##### CSV input file serialization ####

$Data = Import-Csv -Path c:\Temp\MDATP\MachineList.csv

##### Add Tag Block ####

# Added timer to respect API call limits (100 per minute and 1500 per hour)
# Defaulting to the shortest limit, which is 1500 per hour, which equates to 25 calls per minute
# Introduced a 3 sleep at the beginning of every while iteration

# Iterate over the full array
$Data | foreach {

    Start-Sleep -Seconds 3

    $MachineName = $($_.Name);
    $MachineTag = $($_.Tag);

    # Obtain the MachineId from MDATP, based on the ComputerDnsName present in the CSV file
    $url = "https://api.securitycenter.windows.com/api/machines/$MachineName"
        
    $webResponse = Invoke-RestMethod -Method Get -Uri $url -Headers $headers -ErrorAction Stop

    $MachineId = $webResponse.id;

    # Body content will carry the tag specified in the CSV file for the given machine
    $body = @{
       "Value"=$MachineTag;
      "Action"="Add";
    }
    
    # Add specified tag in CSV to the particular MachineId in MDATP
    $url = "https://api.securitycenter.windows.com/api/machines/$MachineId/tags"
    
    $webResponse = Invoke-WebRequest -Method Post -Uri $url -Headers $headers -Body ($body|ConvertTo-Json) -ContentType "application/json" -ErrorAction Stop

    # Clean variables (sanity check)
    $MachineName = $null;
    $MachineTag = $null;
    $MachineId = $null;

}
