# THIS IS A SAMPLE SCRIPT
# PLEASE NOTE THAT I TAKE NO RESPONSIBILITY ON THE RESULTS THIS SCRIPT MIGHT YIELD
# YOU SHOULD TEST IT AND MAKE SURE IT FITS YOUR NEEDS 

# Author: Antonio Vasconcelos
# Twitter: anthonws
# Date/Version/Changelog: 
## 13/05/2020 - V1 - Initial release
## 15/05/2020 - V2 - Added Disk Space and Metered Connection checks

# Local variables
$filename = "$((Get-ComputerInfo).CsName)_$(get-date -Format yyyymmdd_hhmm).dmp"

# Set Working directory to C:\Windows\Temp
Set-Location -Path C:\Windows\Temp

# Check if Connection is Metered
[void][Windows.Networking.Connectivity.NetworkInformation, Windows, ContentType = WindowsRuntime]
$connection = [Windows.Networking.Connectivity.NetworkInformation]::GetInternetConnectionProfile().GetConnectionCost()
$isMetered = $Connection.ApproachingDataLimit -or $cost.OverDataLimit -or $cost.Roaming -or $cost.BackgroundDataUsageRestricted -or ($cost.NetworkCostType -ne "Unrestricted")
if ($isMetered -eq $True) {
    Write-Host ("Connection is Metered. Exiting ...")
    throw(254)
    }

# Check if diskspace is Available
$Memsize=(Get-WmiObject win32_physicalmemory).capacity -as [long]
$DiskFree=(Get-WmiObject win32_logicaldisk -Filter "DeviceID='C:'").freespace -as [long]
if ($Diskfree -le $Memsize) {
    Write-Host ("Not Enough Disk Space. Exiting ...")
    throw(255)
    }

# Get Winpmem binaries
Invoke-WebRequest "https://github.com/Velocidex/c-aff4/releases/download/v3.3.rc3/winpmem_v3.3.rc3.exe" -OutFile winpmem.exe

# Dump Device Memory
# Please note that this will fail in virtual machines that use dynamic memory
.\winpmem.exe -o "C:\Windows\Temp\$filename"

# Install AzCopy into remote device
Invoke-WebRequest -Uri "https://aka.ms/downloadazcopy-v10-windows" -OutFile AzCopy.zip -UseBasicParsing

# Expand AzCopy Archive
Expand-Archive ./AzCopy.zip ./AzCopy -Force

# Set Working directory to C:\Windows\Temp\AzCopy dir
Set-Location -Path C:\Windows\Temp\AzCopy\azcopy_windows_amd64*

# Copy generated dump into Azure Storage using a limited SAS
# It's recommended to minimize the available services and permissions of the SAS Token. Ideally the token should just provide Blob services and Write permissions!!
# PLEASE MAKE SURE TO REPLACE THE FIELDS WITH YOUR INFO
.\azcopy.exe copy "C:\Windows\Temp\$filename" 'https://<AZURE_STORAGE_NAME>.blob.core.windows.net/<CONTAINER_NAME>?<SAS_TOKEN>'
