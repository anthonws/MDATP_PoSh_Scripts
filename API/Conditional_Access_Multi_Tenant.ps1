# THIS IS A SAMPLE SCRIPT
# PLEASE NOTE THAT I TAKE NO RESPONSIBILITY ON THE RESULTS THIS SCRIPT MIGHT YIELD
# YOU SHOULD TEST IT AND MAKE SURE IT FITS YOUR NEEDS

# Author: Antonio Vasconcelos
# Twitter: anthonws
# Date/Version/Changelog:
# 2021-01-22 - 0.1 - Skeleton
# 2021-01-30 - 0.5 - Capable of extracting devices into multi-dimensional object and also to add objects into AAD Group
# 2021-01-31 - 0.6 - Simplified logic for extracting ObjectId
# 2021-01-31 - 0.7 - Added logic to compare Risk Devices with existing group members and remove non-risk devices
# 2021-01-31 - 1.0 - Logic to add Risky Devices into specific CA group (Error Id 400 if device already exists in Group)
# 2021-01-31 - 1.1 - Added filter for Windows10 devices only

# Objective:
# Script retrieves list of devices with High Risk Level and that are AADJoined from Defender for Endpoint, and then adds them into an AAD Group, to enforce a Conditional Access policy
# This script should not be used in favor of the built-in integration with Microsoft Defender for Endpoint and Microsoft Endpoint Manager Intune
# This script is primaly targeted for organizations that have multi-tenancy and therefore cannot use the built-in integration

# TO-DO:
# 1. Add logging logic
# 2. Overall cleanup and bumping

# Clean variables
$ComputerObject = @();
$url = $null;
$webResponse = $null;
$Body = $null;
$Response = $null;
$DeviceId = $null;
$ObjectId = $null;
$DeviceResponse = $null;
$ObjectId = $null;
$Member = $null;
$RemoveMember = $null;
$url = $null;
$headers = $null;
$webResponse = $null;
$ComputerObject = $null;
$GroupMemberList = $null;
$CompareResult = 0;
$i = 0;
$j = 0;

### Defender for Endpoint API App settings
$tenantId = '11111111-1111-1111-1111-11111111' ### Paste your own tenant ID here
$appId = '11111111-1111-1111-1111-11111111' ### Paste your own app ID here
$appSecret = '11111111-1111-1111-1111-11111111' ### Paste your own app keys here

#OAuth
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

#Clean screen
Clear-Host

###################################################################
### Get list of devices with High Risk Level and are AADJoined ####
###################################################################

# Obtain the Risk Device List from Defender for Endpoint
# Conditions are riskScore = High (change this to your will, including adding an or statment for more than 1 riskScore), Windows 10 and AAD Joined
$url = 'https://api-eu.securitycenter.windows.com/api/machines?$filter=riskScore eq ''Medium'' and healthStatus eq ''Active'' and aadDeviceId ne null and osPlatform eq ''Windows10'''

$webResponse = Invoke-RestMethod -Method Get -Uri $url -Headers $headers -ErrorAction Stop

# Save list into a multidimensional object for later use
$webResponse.value | ForEach-Object{
    $item = New-Object PSObject
    $item | Add-Member -type NoteProperty -Name 'ComputerName' -Value $webResponse.value[$i].computerDnsName
    $item | Add-Member -type NoteProperty -Name 'DeviceId' -Value $webResponse.value[$i].aadDeviceId

    $ComputerObject += $item
    $i++
}

###############################
###      AAD CA Section     ###
###############################

# Graph API App settings
$tenantId = '11111111-1111-1111-1111-11111111' ### Paste your own tenant ID here
$appId = '11111111-1111-1111-1111-11111111' ### Paste your own app ID here
$appSecret = '11111111-1111-1111-1111-11111111' ### Paste your own app keys here

# Create a hashtable for the body, the data needed for the token request
# The variables used are explained above
$Body = @{
	'tenant' = $TenantId
	'client_id' = $appId
	'scope' = 'https://graph.microsoft.com/.default'
	'client_secret' = $appSecret
	'grant_type' = 'client_credentials'
}

# Assemble a hashtable for splatting parameters, for readability
# The tenant id is used in the uri of the request as well as the body
$Params = @{
	'Uri' = "https://login.microsoftonline.com/$TenantId/oauth2/v2.0/token"
	'Method' = 'Post'
	'Body' = $Body
	'ContentType' = 'application/x-www-form-urlencoded'
}

$AuthResponse = Invoke-RestMethod @Params -ErrorAction Stop

$Headers = @{
	'Authorization' = "Bearer $($AuthResponse.access_token)"
}

############################################
### Add ObjectId to multi-dimension list ###
############################################

$i = 0;

$ComputerObject | ForEach-Object{
	$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
	$headers.Add("Content-Type", "application/json")
	$headers.Add("Authorization", "Bearer $($AuthResponse.access_token)")

	# Extract DeviceId from the multi-dimensional array
	$DeviceId = $ComputerObject[$i].DeviceId

	# Set URL for GET AAD Object via DeviceId
	$url = "https://graph.microsoft.com/v1.0/devices?$filter=deviceId eq '$DeviceId'"

	# Get Object via DeviceId
	$DeviceResponse = Invoke-RestMethod -Uri $url -Method 'GET' -Headers $headers

	# Extract ObjectId from previous response
	$ObjectId = $DeviceResponse.value.id

    $item | Add-Member -type NoteProperty -Name 'AADObjectId' -Value $ObjectId

	$i++
}

###################################
###   Remove Non-Risky Devices  ###
###################################

# !!! Please modify the script to add the correct Group Id that you have created !!! #
# Example of a CA Group ObjectId: 23f574c5-4711-48c1-8aad-9d2ab80f2c0d

$i = 0;

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("Authorization", "Bearer $($AuthResponse.access_token)")

# Set URL for GET AAD Object via DeviceId
# !! CHANGE GroupId !!
$url = "https://graph.microsoft.com/v1.0/groups/23f574c5-4711-48c1-8aad-9d2ab80f2c0d/members"

# Get Object via DeviceId
$GroupMemberList = Invoke-RestMethod -Uri $url -Method 'GET' -Headers $headers

$GroupMemberList.value | ForEach-Object {
    # Check if Group Member is Risk Devices
    $j = 0;
    $CompareResult = 0;

    $ComputerObject | ForEach-Object{
        # Test unit output
        #Write-Host "Group Member $($GroupMemberList.value[$i].id) - Risky Device $($ComputerObject[$j].AADObjectId)"

        if ($GroupMemberList.value[$i].id -eq $ComputerObject[$j].AADObjectId){
            # Test unit output
            #Write-Host "Group Member $($GroupMemberList.value[$i].id) EQUAL to Risky Device $($ComputerObject[$j].AADObjectId)"
            #Write-Host "Exiting Loop and Moving into next Group Member object"

            # Set Compare variable so that member is retained in CA Group (means that CA Group member existi in Risky Device list)
            $CompareResult = 1
        }
        #else {
            # Test unit output
            #Write-Host "Group Member $($GroupMemberList.value[$i].id) NOT EQUAL to Risky Device $($ComputerObject[$j].AADObjectId)"
        #}

        $j++
    }

    # Remove Member if not Risky Device
    if ($CompareResult -eq 0){
        $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
	    $headers.Add("Content-Type", "application/json")
	    $headers.Add("Authorization", "Bearer $($AuthResponse.access_token)")

        $Member = $GroupMemberList.value[$i].id

        Write-Host $Member

	    # Set URL for GET AAD Object via DeviceId
	    $url = "https://graph.microsoft.com/v1.0/groups/23f574c5-4711-48c1-8aad-9d2ab80f2c0d/members/$Member/`$ref"

        Write-Host $url

	    # Get Object via DeviceId
	    $RemoveMember = Invoke-RestMethod -Uri $url -Method 'DELETE' -Headers $headers
    }

	$i++
}

##################################
### Add Risky Devices To Group ###
##################################

# !!! Please modify the script to add the correct Group Id that you have created !!! #
# MDECA Group ObjectId: 23f574c5-4711-48c1-8aad-9d2ab80f2c0d

$i = 0;

$ComputerObject | ForEach-Object{
	$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
	$headers.Add("Content-Type", "application/json")
	$headers.Add("Authorization", "Bearer $($AuthResponse.access_token)")

    $ObjectId = $ComputerObject[$i].AADObjectId

	# Set Body for POST with the mapped ObjectId
	$Body = "{`"@odata.id`": `"https://graph.microsoft.com/v1.0/directoryObjects/$ObjectId`"}"

	# Add member to MDECA group, via previously obtained ObjectId
	# A 404 will be returned if the ObjectId is already a member of the group
	Try {
		$AddMemberResponse = Invoke-RestMethod 'https://graph.microsoft.com/v1.0/groups/23f574c5-4711-48c1-8aad-9d2ab80f2c0d/members/$ref' -Method 'POST' -Headers $headers -Body $Body
	} Catch {
		if($_.Exception.Message -like '*(400)*'){
            Write-Host ""
            Write-Host "Device " -ForegroundColor Yellow -NoNewline; Write-Host $($ComputerObject[$i].ComputerName) -ForegroundColor Red -NoNewline; Write-Host " - " -NoNewline; Write-Host $($ComputerObject[$i].DeviceId) -ForegroundColor Red -NoNewline; Write-Host " already a member of the group." -ForegroundColor Yellow
            Write-Host ""
            Return
        }
        if($_.Exception.Message -like '*(404)*'){
            Write-Host ""
            Write-Host "Device " -ForegroundColor Yellow -NoNewline; Write-Host $($ComputerObject[$i].ComputerName) $($ComputerObject[$i].DeviceId) -ForegroundColor Red -NoNewline; Write-Host " does not exist." -ForegroundColor Yellow
            Write-Host ""
            Return
		} else {
			Write-Host $_
            Return
		}
	}

	$i++
}

# Clean variables (sanity check)
$ComputerObject = $null;
$url = $null;
$webResponse = $null;
$Body = $null;
$Response = $null;
$DeviceId = $null;
$ObjectId = $null;
$DeviceResponse = $null;
$ObjectId = $null;
$Member = $null;
$RemoveMember = $null;
$url = $null;
$headers = $null;
$webResponse = $null;
$ComputerObject = $null;
$GroupMemberList = $null;
$CompareResult = $null;
$i = $null;
$j = $null;
