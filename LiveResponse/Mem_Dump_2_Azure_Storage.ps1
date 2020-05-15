## LIVE RESPONSE FULL MEMORY DUMP COLLECTION TO AZURE BLOB STORAGE ##

# Author: António Vasconcelos
# Release Notes
## V1 - 13/05/2020
### Initial release.

# Local variables
$filename = "$((Get-ComputerInfo).CsName)_$(get-date -Format yyyymmdd_hhmm).dmp"

# Set Working directory to C:\Windows\Temp
Set-Location -Path C:\Windows\Temp

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
