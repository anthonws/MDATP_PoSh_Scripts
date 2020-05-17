# THIS IS A SAMPLE SCRIPT
# PLEASE NOTE THAT I TAKE NO RESPONSIBILITY ON THE RESULTS THIS SCRIPT MIGHT YIELD
# YOU SHOULD TEST IT AND MAKE SURE IT FITS YOUR NEEDS 

# Author: Antonio Vasconcelos
# Twitter: anthonws
# Date/Version/Changelog: 
## 13/05/2020 - V1 - Initial release
## 15/05/2020 - V2 - Added Disk Space and Metered Connection checks
## 16/05/2020 - V3 - Added execution status messages. Added variables for Azure Storage Account information
## 17/05/2020 - V4 - Creation of dump independent of connection type.

function Write-Status($text) {
    write-host "[*] " -ForegroundColor Green -NoNewline
    write-host $text
    }

#Azure Variables - Enter your Information below.
$AzStorageName = "STORAGEACCOUNT"  # Example "test" for test.blob.core.windows.net
$AzContainerName = "CONTAINER" 
$AzSAStoken = "YOUR SAS TOKEN"

$DiskOverhead = 1.2. # 20% overhead assumed for disk space calculation.

$AzureURI = "https://"+$AzStorageName".blob.core.windows.net/"+$AzContainerName+"?" + $AzSAStoken # DO NOT TOUCH THIS LINE

write-status "Starting Script"
# Local variables
# $filename = "$((Get-ComputerInfo).CsName)_$(get-date -Format yyyymmdd_hhmm).dmp"
# Using $env:COMPUTERNAME is faster
$filename = "$($env:COMPUTERNAME)_$(get-date -Format yyyymmdd_hhmm).dmp"
# Set Working directory to C:\Windows\Temp
Set-Location -Path C:\Windows\Temp

# Check if Connection is Metered
write-status "Checking for Metered Connection ..."
[void][Windows.Networking.Connectivity.NetworkInformation, Windows, ContentType = WindowsRuntime]
$connection = [Windows.Networking.Connectivity.NetworkInformation]::GetInternetConnectionProfile().GetConnectionCost()
$isMetered = $Connection.ApproachingDataLimit -or $cost.OverDataLimit -or $cost.Roaming -or $cost.BackgroundDataUsageRestricted -or ($cost.NetworkCostType -ne "Unrestricted")

if ($isMetered -eq $True) {
    Write-Host ("[!] Connection is Metered. Dump will not be uploaded") -ForegroundColor Red   
    }
else {
    Write-Status "Connection is not metered. Dump will be uploaded to Azure"
    }
    
# Check if diskspace is Available
write-status "Checking for Memory & Available Disk Space"
$Memsize=(Get-WmiObject win32_physicalmemory).capacity -as [long]
$DiskFree=(Get-WmiObject win32_logicaldisk -Filter "DeviceID='C:'").freespace -as [long]

if ($Diskfree -le $Memsize * $DiskOverhead) {
    Write-host ("[!] Not Enough Disk Space. Exiting ...") -ForegroundColor Red
    return
    }

# Get Winpmem binaries
write-status "Downloading Memory Dumping tool ..."
Invoke-WebRequest "https://github.com/Velocidex/c-aff4/releases/download/v3.3.rc3/winpmem_v3.3.rc3.exe" -OutFile winpmem.exe

# Dump Device Memory
# Please note that this will fail in virtual machines that use dynamic memory
.\winpmem.exe -o "C:\Windows\Temp\$filename"

# Install AzCopy into remote device
write-status "Downloading AzCopy ..."
Invoke-WebRequest -Uri "https://aka.ms/downloadazcopy-v10-windows" -OutFile AzCopy.zip -UseBasicParsing

# Expand AzCopy Archive
write-status "Expanding AzCopy ..."
Expand-Archive ./AzCopy.zip ./AzCopy -Force

# Set Working directory to C:\Windows\Temp\AzCopy dir
Set-Location -Path C:\Windows\Temp\AzCopy\azcopy_windows_amd64*

# Copy generated dump into Azure Storage using a limited SAS
# It's recommended to minimize the available services and permissions of the SAS Token. Ideally the token should just provide Blob services and Write permissions!!
# PLEASE MAKE SURE TO REPLACE THE FIELDS WITH YOUR INFO

if ($isMetered -eq $False) {
    write-status "Copying memory dump to your container " $AzContainerName
    .\azcopy.exe copy "C:\Windows\Temp\$filename" $AzureURI 2>&1 
    }
else {
    Write-Host "[!] Dump is created but  not uploaded. Metered connection detected." -ForegroundColor Yellow
    Write-Host "[!] Dump is located at C:\Windows\Temp\$filename" -ForegroundColor Yellow 
    }
    
write-status "Execution Completed"
