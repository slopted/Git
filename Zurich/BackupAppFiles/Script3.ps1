$nroChange = Read-Host -Prompt 'Input your Change Number:'
$appServiceName = 'LA-CL-API-WEBAPP00'
$fileName = $appServiceName + $nroChange
Write-Host "You change number is:'$nroChange' and '$User' on '$Date'"



$yeah = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes","Description."
$nah = New-Object System.Management.Automation.Host.ChoiceDescription "&No","Description."
$abort = New-Object System.Management.Automation.Host.ChoiceDescription "&Cancel","Description."
$options = [System.Management.Automation.Host.ChoiceDescription[]]($yeah, $nah, $abort)
$heading = "Demo"
$mess = "are you sure you want to continue?"
$rslt = $host.ui.PromptForChoice($heading, $mess, $options, 1)
switch ($rslt) {
    0{ 
        Write-Host "Yes" -ForegroundColor Green
    }1{
    Write-Host "No" -ForegroundColor Red
    }2{
    Write-Host "Cancel" -ForegroundColor Red
    }
    }







$username = "`$LA-CL-API-WEBAPP00"
$password = "QKg8CcapoYlz0oEovC0zjbtvyyx7bcuJD3jy9bDQYZnauA842k4Cj5j1yweu"

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username, $password)))
$userAgent = "powershell/1.0"
$appServiceName = 'LA-CL-API-WEBAPP00'

$apiUrl = https://$appServiceName.scm.azurewebsites.net:443/api/zip/site/wwwroot/

$filePath = "c:\temp\$fileName.zip"
Invoke-RestMethod -Uri $apiUrl -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -UserAgent $userAgent -Method GET -OutFile $filePath -ContentType "multipart/form-data"
