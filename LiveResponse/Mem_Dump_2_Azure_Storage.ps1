# THIS IS A SAMPLE SCRIPT
# PLEASE NOTE THAT WE TAKE NO RESPONSIBILITY ON THE RESULTS THIS SCRIPT MIGHT YIELD
# YOU SHOULD TEST IT AND MAKE SURE IT FITS YOUR NEEDS 

# Author: anthonws, @anthonws
# Contributors: cventour, @Clechuck
#
# Date/Version/Changelog: 
## 13/05/2020 - V1 - Initial release
## 15/05/2020 - V2 - Added Disk Space and Metered Connection checks
## 16/05/2020 - V3 - Added execution status messages. Added variables for Azure Storage Account information
## 17/05/2020 - V4 - Creation of dump independent of connection type.
## 23/05/2020 - V5 - Typos fix and other cleanup stuff. Script will now download latest WinpMem release available.

function Write-Status($text) {
    write-host "[*] " -ForegroundColor Green -NoNewline
    write-host $text
    }

#Azure Variables - Enter your Azure Storage information below.
# It's recommended to minimize the available services and permissions of the SAS Token. Ideally the token should just provide Blob services and Write permissions!!
$AzStorageName = "STORAGEACCOUNT"  # Example "test" for test.blob.core.windows.net
$AzContainerName = "CONTAINER" 
$AzSAStoken = "YOUR SAS TOKEN"

$DiskOverhead = 1.2. # 20% overhead assumed for disk space calculation.

$AzureURI = "https://"+$AzStorageName".blob.core.windows.net/"+$AzContainerName+"?" + $AzSAStoken # DO NOT TOUCH THIS LINE

Write-Status "Starting Script"

# Local variables
$filename = "$($env:COMPUTERNAME)_$(get-date -Format yyyymmdd_hhmm).dmp"
# Set Working directory to C:\Windows\Temp
Set-Location -Path C:\Windows\Temp

# Check if Connection is Metered
Write-Status "Checking for Metered Connection..."
[void][Windows.Networking.Connectivity.NetworkInformation, Windows, ContentType = WindowsRuntime]
$connection = [Windows.Networking.Connectivity.NetworkInformation]::GetInternetConnectionProfile().GetConnectionCost()
$isMetered = $Connection.ApproachingDataLimit -or $cost.OverDataLimit -or $cost.Roaming -or $cost.BackgroundDataUsageRestricted -or ($cost.NetworkCostType -ne "Unrestricted")

if ($isMetered -eq $True) {
    Write-Status ("[!] Connection is Metered. Dump will NOT be uploaded.") -ForegroundColor Red   
    }
else {
    Write-Status "Connection is not Metered. Dump will be uploaded to Azure."
    }
    
# Check if diskspace is Available
Write-Status "Checking for Memory & Available Disk Space..."
$Memsize=(Get-WmiObject win32_physicalmemory).capacity -as [long]
$DiskFree=(Get-WmiObject win32_logicaldisk -Filter "DeviceID='C:'").freespace -as [long]

if ($Diskfree -le $Memsize * $DiskOverhead) {
    Write-Status ("[!] Not Enough Disk Space. Exiting.") -ForegroundColor Red
    return
    }

# Get Winpmem binaries

Write-Status "Downloading Memory dumping tool..."

$repo = "Velocidex/c-aff4"
$file = "winpmem_"
$releases = "https://api.github.com/repos/$repo/releases"

Write-Status "Determining latest release"
$tag = (Invoke-WebRequest $releases | ConvertFrom-Json)[0].tag_name
$download = "https://github.com/$repo/releases/download/$tag/$file$tag.exe"

Invoke-WebRequest $download -OutFile winpmem.exe

# Dump Device Memory
# Please note that this will fail in virtual machines that use dynamic memory

Write-Status "Dumping memory..."
.\winpmem.exe -o "C:\Windows\Temp\$filename"

# Install AzCopy into remote device
write-status "Downloading AzCopy ..."
Invoke-WebRequest -Uri "https://aka.ms/downloadazcopy-v10-windows" -OutFile AzCopy.zip -UseBasicParsing

# Expand AzCopy Archive
write-status "Expanding AzCopy..."
Expand-Archive ./AzCopy.zip ./AzCopy -Force

# Set Working directory to C:\Windows\Temp\AzCopy dir
Set-Location -Path C:\Windows\Temp\AzCopy\azcopy_windows_amd64*

# Copy generated dump into Azure Storage using a limited SAS
if ($isMetered -eq $False) {
    Write-Status "Copying memory dump to your Azure Storage container " $AzContainerName
    .\azcopy.exe copy "C:\Windows\Temp\$filename" $AzureURI 2>&1 
    }
else {
    Write-Host "[!] Dump was succssefully created but not uploaded. Metered connection detected." -ForegroundColor Yellow
    Write-Host "[!] Dump is located at C:\Windows\Temp\$filename" -ForegroundColor Yellow 
    }
    
write-status "!Execution Completed!"
