# THIS IS A SAMPLE SCRIPT
# PLEASE NOTE THAT WE TAKE NO RESPONSIBILITY ON THE RESULTS THIS SCRIPT MIGHT YIELD
# YOU SHOULD TEST IT AND MAKE SURE IT FITS YOUR NEEDS 

# Author: anthonws, @anthonws
# Contributors: cventour, @Clechuck
#
# Date/Version/Changelog: 
## 13/05/2020 - V1
## - Initial release.
##
## 15/05/2020 - V2
## - Added Disk Space and Metered Connection checks.
##
## 16/05/2020 - V3
## - Added execution status messages.
## - Added variables for Azure Storage Account information.
##
## 17/05/2020 - V4
## - Creation of dump independent of connection type.
##
## 23/05/2020 - V5
## - Typos fix and other cleanup stuff.
## - Script will now download latest WinpMem release available.
##
## 23/05/2020 - V6
## - Added File Split support via winpmem --split option.
##
## 23/05/2020 - V7
## - Added more custom format logging messages.
## - Fixed Metered Connection check.
## - Added Azure Storage required parameters
## - Added check for elevated rights.
##
## 16/03/2021 - V8
## - Now for realz, fixing metered connection check.
##
## 16/03/2021 - V9
## - New version of WinPMem (fixes VSM issues)
## - Changed code to get latest release from new GitHub repo and check for download_url instead of tag

## !!! Instructions !!!! ###
## https://docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview
## Create a Blob storage
## Create a Container
## Create a SAS token with Blob + Container + Write rights only
## Use the Blob sotrage name
## Do NOT change the variables for Azure URI or params directly! The script will prompt you to add the needed info!

# Custom format for logging messages
function Write-Status($text) {
    write-host "[I] " -ForegroundColor Green -NoNewline
    write-host $text
    }

function Write-Sub-Status($text) {
    write-host "[*][I] " -ForegroundColor Green -NoNewline
    write-host $text
}

function Write-Error($text) {
    write-host "[E] " -ForegroundColor Red -NoNewline
    write-host $text
}

function Write-Sub-Error($text) {
    write-host "[*][E] " -ForegroundColor Red -NoNewline
    write-host $text
}

function Write-Warning($text) {
    write-host "[W] " -ForegroundColor Orange -NoNewline
    write-host $text
}

function Write-Sub-Warning($text) {
    write-host "[*][W] " -ForegroundColor Orange -NoNewline
    write-host $text
}

## Global variables ##

# Dynamic DMP filename, based on Hostname and Date and Time
$filename = "$($env:COMPUTERNAME)_$(get-date -Format yyyymmdd_hhmm).raw"

# Set Working directory to C:\Windows\Temp
Set-Location -Path C:\Windows\Temp

# Free disk space overhead multiplier
$DiskOverhead = 1.2 # 20% overhead assumed for disk space calculation.

# Get current User Principal
$user = [Security.Principal.WindowsIdentity]::GetCurrent();

# Winpmem Split File
$SplitDump = $False # If $True dump will be split into multiple files
$SplitChunkSize = "200m" # Size per memory dump chunk. Written as winpmem requires

# Required parameters for Azure URI
# It's recommended to minimize the available services and permissions of the SAS Token. Ideally the token should just provide Blob services and Write permissions!!
Function AzureInfo {
 param(
    [Parameter(Position=0,mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        $AzStorageName=$(throw "Azure Storage name is mandatory, please provide a value."),
    [Parameter(Position=1,mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        $AzContainerName=$(throw "Azure Storage Container name is mandatory, please provide a value."),
    [Parameter(Position=2,mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        $AzSAStoken=$(throw "Azure Storage SAS Token is mandatory, please provide a value.")
) #end param
 process{
    #Check if any parameter is null or empty
    if ($AzStorageName -eq $null -or $AzContainerName -eq $null -or $AzSAStoken -eq $null -or $AzStorageName -eq "" -or $AzContainerName -eq "" -or $AzSAStoken -eq ""){
        Write-Sub-Error ("Invalid required parameters. Please input Azure Storage parameters.")
        AzureInfo
    }
    else{
        # Azure Blob Storage Dynamic URI
        $AzureURI = "https://"+$AzStorageName+".blob.core.windows.net/"+$AzContainerName+"?" + $AzSAStoken # DO NOT TOUCH THIS LINE
        return $AzureURI
    }
    } #end function
}

# Script Main
Write-Status "Starting Script..."

Write-Status "Checking for Elevated Rights (Admin)..."

if ((New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator) -eq $False) {
    Write-Sub-Error "Session not elevated. Exiting."
    return
    }

# Get required Azure URI info
Write-Status "Please input required Azure Storage information..."
$AzureURI = AzureInfo

# Check if required disk space is available
Write-Status "Checking for Available Disk Space..."
$Memsize=(Get-WmiObject win32_physicalmemory).capacity -as [long]
$DiskFree=(Get-WmiObject win32_logicaldisk -Filter "DeviceID='C:'").freespace -as [long]

if ($Diskfree -le $Memsize * $DiskOverhead) {
    Write-Sub-Error ("Not Enough Disk Space. Exiting.") -ForegroundColor Red
    return
    }

# Get Winpmem binaries
Write-Status "Downloading Memory dumping tool..."

$repo = "Velocidex/WinPmem"
$filenamePattern = "*x64*.exe"
$releases = "https://api.github.com/repos/$repo/releases"

$releasesUri = "https://api.github.com/repos/$repo/releases/latest"
$downloadUri = ((Invoke-RestMethod -Method GET -Uri $releasesUri).assets | Where-Object name -like $filenamePattern ).browser_download_url

Invoke-WebRequest $downloadUri -OutFile winpmem.exe

# Dump Device Memory
# Please note that this will fail in virtual machines that use dynamic memory

if ($SplitDump -eq $False) {
    Write-Status "Dumping memory..."
    .\winpmem.exe "C:\Windows\Temp\$filename"
}
else {
    Write-Status "Dumping memory in $SplitChunkSize byte chunks"
    .\winpmem.exe "C:\Windows\Temp\$filename" --split $SplitChunkSize
}

# Install AzCopy into remote device
write-status "Downloading AzCopy ..."
Invoke-WebRequest -Uri "https://aka.ms/downloadazcopy-v10-windows" -OutFile AzCopy.zip -UseBasicParsing

# Expand AzCopy Archive
write-status "Expanding AzCopy..."
Expand-Archive ./AzCopy.zip ./AzCopy -Force

# Set Working directory to C:\Windows\Temp\AzCopy dir
Set-Location -Path C:\Windows\Temp\AzCopy\azcopy_windows_amd64*

# Check if Connection is Metered
Write-Status "Checking for Metered Connection..."
[void][Windows.Networking.Connectivity.NetworkInformation, Windows, ContentType = WindowsRuntime]
$connection = [Windows.Networking.Connectivity.NetworkInformation]::GetInternetConnectionProfile().GetConnectionCost()

# Copy generated dump into Azure Storage using a limited SAS
if ($Connection.ApproachingDataLimit -eq "True" -or $connection.OverDataLimit -eq "True" -or $connection.Roaming -eq "True" -or $connection.BackgroundDataUsageRestricted -eq "True" -or $connection.NetworkCostType -ne "Unrestricted") {
    Write-Status "Dump was successfully created but NOT uploaded. Metered connection detected."
    Write-Status "Dump is located at C:\Windows\Temp\$filename"
    }
else {
    Write-Sub-Status "Connection is not Metered. Dump will be uploaded to Azure."
    Write-Sub-Status "Copying memory dump to your Azure Storage container " $AzContainerName
    .\azcopy.exe copy "C:\Windows\Temp\$filename*" "$AzureURI" --check-length=false 2>&1 
    }
    
write-status "Execution Completed! Exiting."
