POST https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/restart?api-version=2022-03-01

POST https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/restart?api-version=2022-03-01

az webapp stop --name LA-CL-APP-WEBAPP07 --resource-group la-cl-apps-soap

POST https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/restart?api-version=2022-03-01



$tenant="473672ba-cd07-4371-a2ae-788b4c61840e"
$uri="https://login.microsoftonline.com/"+$tenant+"/oauth2/token"
$clientid="12806df5-f622-4354-b44d-ee6977c8009f"
$client_secret="R698Q~Xknrn0MbIoev~_-WzU6Iy6.GyCH0~V5b71"
$postParams = @{client_id=$clientid;client_secret=$client_secret;grant_type='client_credentials'; resource='https://dev.azuresynapse.net/';scope='Microsoft.Synapse/workspaces/read'}
$response = Invoke-RestMethod $uri -Method 'POST' -Body $postParams
$response | ConvertTo-Json | out-null

$accesstoken = $response.access_token
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("accept", "application/json")
$headers.Add("Authorization", "Bearer $accesstoken")
$synuri="la-cl-rg-bi-modern-wps-synapse.dev.azuresynapse.net"
 #$pipeline="pl_dimviadepago"$uri="https://"+$synuri+"/pipelines/"+ $pipeline +"/createRun?api-version=2020-12-01"$response = Invoke-RestMethod $uri -Method 'POST' -Headers $headers $response | ConvertTo-Json  | out-null
  $uri="https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/restart?api-version=2022-03-01"
 $response = Invoke-RestMethod $uri -Method 'POST' -Headers $headers 
 $response | ConvertTo-Json | out-null
