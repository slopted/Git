##PROD##
#Set-AzContext -Subscription "681b3fc7-7337-4919-8063-586130a56c9f"
##QA##
Set-AzContext -Subscription "251f8d88-2d55-4b29-bb93-c4feb93b3f8a"
$nroChange = 'CHG9298272'
$appServiceName = 'LA-CL-API-WEBAPP00'
$date = Get-Date
$fileName = $appServiceName + '-' +$nroChange + '-' + $date.Day +"-"+$date.Month +"-"+ $date.Year

Write-Host "Your change number is:'$nroChange'"
Write-Host "Your App Service name is:'$appServiceName'"
Write-Host "Your backup file name will be:'$fileName'"


        $username = "`$" + $appServiceName
        $password = Get-AzKeyVaultSecret -VaultName "LA-CL-KEYV-AUTOMATION" -Name "$appServiceName" -AsPlainText
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username, $password)))
        $userAgent = "powershell/1.0"
        $apiUrl = "https://"+$appServiceName+".scm.azurewebsites.net:443/api/zip/site/wwwroot/"
        $filePath = "c:\temp\$fileName.zip"

        Invoke-RestMethod -Uri $apiUrl -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -UserAgent $userAgent -Method GET -OutFile $filePath -ContentType "multipart/form-data"
        Remove-Variable password
        Remove-Variable base64AuthInfo
        
                    $resourceGroupName = 'LA-CL-IaaS-Automation'
                    $storageAccName = 'lsclsaautomation'
                    $fileShareName = 'backups'
                    $folderPath = 'BackupSOAP'

                    Write-Host -ForegroundColor Green "Uploading files to file share.."    
                    ## Get the storage account context  
                    $ctx=(Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccName).Context  
                    ## Get the file share  
                    $fileShare=Get-AZStorageShare -Context $ctx -Name $fileShareName  
                    ## Upload the file  
                    Set-AzStorageFileContent -ShareName $fileShare.Name -Context $ctx -Source $filePath -Path $folderPath -Force
                    Write-Host -ForegroundColor Green "Files uploaded to file share"