<#
.NOTES
Filename : MoveFiles
Author : Andres Sanchez
Version : 1.0
Date : 4-Abril-2023
#>

Param (
[Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]
[String] $sourceAzureSubscriptionId,
[Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]
[String] $sourceStorageAccountRG,
[Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]
[String] $targetStorageAccountRG,
[Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]
[String] $sourceStorageAccountName,
[Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]
[String] $targetStorageAccountName,
[Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]
[String] $sourceStorageFileShareName,
[Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]
[String] $targetStorageFileShareName,
[Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]
[Int] $numberOfDays
)

# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process

# Connect to Azure with system-assigned managed identity (automation account)
Connect-AzAccount -Identity

# Set Azure Subscription context
Set-AzContext -Subscription $sourceAzureSubscriptionId

#! Source Storage Account (hot file share)
# Get Source Storage Account Key
$sourceStorageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $sourceStorageAccountRG -Name $sourceStorageAccountName).Value[0]

# Set Azure Storage Context
$sourceContext = New-AzStorageContext -StorageAccountKey $sourceStorageAccountKey -StorageAccountName $sourceStorageAccountName

# Set Azure Storage Context
$sourceContext = New-AzStorageContext -StorageAccountKey $sourceStorageAccountKey -StorageAccountName $sourceStorageAccountName

# Generate source file share SAS URI Token with read, delete, and list permission
$sourceShareSASURI = New-AzStorageAccountSASToken -Context $sourceContext `
-Service File -ResourceType Service,Container,Object -ExpiryTime(get-date).AddDays(1) -Permission "rdl"
$sourceShareSASURI = $sourceShareSASURI.Split('?')[-1]

# List Directories and Files on the source hot file share
$URI = "https://$sourceStorageAccountName.file.core.windows.net/$($sourceStorageFileShareName)?comp=list&restype=directory&include=timestamps&$($sourceShareSASURI)"
$response = Invoke-RestMethod $URI -Method 'GET'

# Fix XML Response body
$fixedXML = $response.Replace('ï»¿<?xml version="1.0" encoding="utf-8"?>','<?xml version=''1.0'' encoding=''UTF-8''?>')
$doc = New-Object xml
$doc = [xml]$fixedXML
if($doc.FirstChild.NodeType -eq 'XmlDeclaration') {
$doc.FirstChild.Encoding = $null
}

#! TARGET Storage Account (cool file share)
# Get Target Storage Account Key
$targetStorageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $targetStorageAccountRG -Name $targetStorageAccountName).Value[0]

# Set Target Azure Storage Context
$destinationContext = New-AzStorageContext -StorageAccountKey $targetStorageAccountKey -StorageAccountName $targetStorageAccountName

# Generate target SAS URI with read, write, delete, create, and list permission
$targetShareSASURI = New-AzStorageShareSASToken -Context $destinationContext `
-ExpiryTime(get-date).AddDays(1) -ShareName $targetStorageFileShareName -Permission "rwdcl"

# Construct old date based on the desired number of days
$old = ((Get-Date).ToUniversalTime()).adddays(-$numberOfDays)
$oldDate = $old.ToString("yyyy-MM-ddTHH:mm:ss.fffffffK")

# The container image (peterdavehello/azcopy:latest) is publicly available on Docker Hub and has the latest AzCopy version installed
# You could also create your own private container image and use it instead
# When you create a new container instance, the default compute resources are set to 1vCPU and 1.5GB RAM
# We recommend starting with 2vCPU and 4GB memory for larger file shares (E.g. 3TB)
# You may need to adjust the CPU and memory based on the size and churn of your file share
# The container will be created in the $location variable based on the source storage account location. Adjust if needed.
$location = (Get-AzResourceGroup -Name $sourceStorageAccountRG).location

# Container Group Name
$containerGroupName = $sourceStorageFileShareName + "-azcopy-job"

# Set the AZCOPY_BUFFER_GB value at 2 GB which would prevent the container from crashing.
$envVars = New-AzContainerInstanceEnvironmentVariableObject -Name "AZCOPY_BUFFER_GB" -Value "2"

foreach ($file in $doc.EnumerationResults.entries.file) {
# If the file LastAccessTime is less than or equal to the number of days, then move it to the cool tier
if ($file.properties.LastAccessTime -le $oldDate) {
$sourceFile = "https://$sourceStorageAccountName.file.core.windows.net/$sourceStorageFileShareName/$($file.name)?$($sourceShareSASURI)"
$targetFile = "https://$targetStorageAccountName.file.core.windows.net/$targetStorageFileShareName/$($file.name)$($targetShareSASURI)"
# Copy the file to the target file share
$command1 = "azcopy","copy",$sourceFile,$targetFile,"--preserve-smb-info","--preserve-smb-permissions"
# Remove the file from the source file share
$command2 = "azcopy","remove",$sourceFile

# Create Azure Container Instance Object for $command1
$container = New-AzContainerInstanceObject `
-Name $containerGroupName `
-Image "peterdavehello/azcopy:latest" `
-RequestCpu 2 -RequestMemoryInGb 4 `
-Command $command1 -EnvironmentVariable $envVars

# Create Azure Container Group and copy the file to the target file share cool tier
$containerGroup = New-AzContainerGroup -ResourceGroupName $sourceStorageAccountRG -Name $containerGroupName `
-Container $container -OsType Linux -Location $location -RestartPolicy never

# Recreate Azure Container Instance Object for $command2
$container = New-AzContainerInstanceObject `
-Name $containerGroupName `
-Image "peterdavehello/azcopy:latest" `
-RequestCpu 2 -RequestMemoryInGb 4 `
-Command $command2 -EnvironmentVariable $envVars

# Recreate the same Azure Container Group and remove the file from the source file share hot tier
$containerGroup = New-AzContainerGroup -ResourceGroupName $sourceStorageAccountRG -Name $containerGroupName `
-Container $container -OsType Linux -Location $location -RestartPolicy never
}
}

Write-Output ("")