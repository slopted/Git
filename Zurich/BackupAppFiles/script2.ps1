$appServiceName = 'LA-CL-API-WEBAPP00'
 $credential = Get-Credential
 
 $syncParams = @{
     SourcePath = 'wwwroot'
     TargetPath = '/home/andres/backup/LA-CL-API-WEBAPP00'
     ComputerName = "https://$appServiceName.scm.azurewebsites.net:443/msdeploy.axd?site=$appServiceName"
     Credential = $credential
 }
 Sync-Website @syncParams


 https://your-site.scm.azurewebsites.net/api/zip/site/wwwroot/

 https://$appServiceName.scm.azurewebsites.net:443/api/zip/site/wwwroot/





https://LA-CL-API-WEBAPP00.scm.azurewebsites.net:443/api/zip/site/wwwroot/
https://LA-CL-API-WEBAPP00.scm.azurewebsites.net:443/api/zip/site/wwwroot/
https://LA-CL-API-WEBAPP00.scm.azurewebsites.net:443/api/zip/site/wwwroot/
https://LA-CL-API-WEBAPP00.scm.azurewebsites.net:443/api/zip/site/wwwroot/
https://LA-CL-API-WEBAPP00.scm.azurewebsites.net:443/api/zip/site/wwwroot/
https://LA-CL-API-WEBAPP00.scm.azurewebsites.net:443/api/zip/site/wwwroot/
https://LA-CL-API-WEBAPP00.scm.azurewebsites.net:443/api/zip/site/wwwroot/

$appServiceName = 'LA-CL-API-WEBAPP00'
https://$appServiceName.scm.azurewebsites.net:443/api/zip/site/wwwroot/




appServiceName = 'LA-CL-API-WEBAPP00'
curl -o $appServiceName.zip -i -X GET https://$appServiceName.scm.azurewebsites.net:443/api/zip/site/wwwroot/ -u $sitename:password


Invoke-WebRequest -OutFile $appServiceName.zip -URI https://$appServiceName.scm.azurewebsites.net:443/api/zip/site/wwwroot/ 

$appCredentials = Get-Credential
-Credential $appCredentials

credentials
$appServiceName = 'LA-CL-API-WEBAPP00'
$syncParams = @{
    Uri = 'https://$appServiceName.scm.azurewebsites.net:443/api/zip/site/wwwroot/'
    Method = 'GET'
    OutFile = C:\Temp\$appServiceName.zip
}
Invoke-WebRequest @syncParams




Invoke-WebRequest 
Uri = "$baseUri/v7.2.5/PowerShell-7.2.5-win-x64.msi"
        OutFile = 'PowerShell-7.2.5-win-x64.msi'



 curl -X PUT --data-binary @foo.zip https://LA-CL-API-WEBAPP00.scm.azurewebsites.net:443/api/zip/site/wwwroot/ -u 
 $Tmp676767:7fgxQYjitttkwJBG5rq2AykGGickx5gGlgw8jXNX3YlE1q5rv8Sb7XY3AlAK




 #Save-AzrWebApp -Name 'LA-CL-API-WEBAPP00' -TargetPath '/home/andres/backup/LA-CL-API-WEBAPP00' -Credential (Get-Credential)




<#
$cred = Get-Credential
New-WDPublishSettings -ComputerName owais-1 -Site Site1 -Credentials $cred -AllowUntrusted -SiteUrl "https://www.mywebsite.com" -FileName C:\pprofiles\mywebsite.publishsettings -AgentType wmsvc
Get-WDPublishSettings cmdlet allows to load values from a publish setting file into PublishSettings object.
$publishsettings=Get-WDPublishSettings C:\pprofiles\mywebsite.publishsettings

msdeploy -verb:sync  -source:metakey=l m/w3svc/1 -dest:package=c:\Site1.zip > WebDeployPackage.log

az webapp deploy --resource-group <group-name> --name <app-name> 
--src-url "https://storagesample.blob.core.windows.net/sample-container/myapp.zip?sv=2021-10-01&sb&sig=slk22f3UrS823n4kSh8Skjpa7Naj4CG3

#>