Set-AzContext -Subscription "251f8d88-2d55-4b29-bb93-c4feb93b3f8a"

$ResourceGroupName = "LA-CL-APIS-SOAP"
$AppServicePlan = "LA-CL-APIPLAN-P1"
$Tier = "PremiumV2" 
$Size = "Small"
$app=Get-AzureRmAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlan
$apps=Get-AzureRmWebApp -AppServicePlan $app

Set-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlan -Tier "$Tier" -WorkerSize "$Size"
Set-AzAppServicePlan -NumberofWorkers 1 -Name $AppServicePlan -ResourceGroupName $ResourceGroupName

Foreach($app in $apps)
{
 $websiteName = $app.Name
 Restart-AzureRmWebApp -ResourceGroupName $app.ResourceGroup -Name $websiteName
}




$AppServicePlan = "LA-CL-APIPLAN-P2"
$Tier = "PremiumV2" 
$Size = "Large"
$app=Get-AzureRmAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlan
$apps=Get-AzureRmWebApp -AppServicePlan $app

Set-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlan -Tier "$Tier" -WorkerSize "$Size"
Set-AzAppServicePlan -NumberofWorkers 1 -Name $AppServicePlan -ResourceGroupName $ResourceGroupName

Foreach($app in $apps)
{
 $websiteName = $app.Name
 Restart-AzureRmWebApp -ResourceGroupName $app.ResourceGroup -Name $websiteName
}





$AppServicePlan = "LA-CL-APIPLAN-P3-1"
$Tier = "PremiumV2" 
$Size = "Small"
$app=Get-AzureRmAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlan
$apps=Get-AzureRmWebApp -AppServicePlan $app

Set-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlan -Tier "$Tier" -WorkerSize "$Size"
Set-AzAppServicePlan -NumberofWorkers 1 -Name $AppServicePlan -ResourceGroupName $ResourceGroupName

Foreach($app in $apps)
{
 $websiteName = $app.Name
 Restart-AzureRmWebApp -ResourceGroupName $app.ResourceGroup -Name $websiteName
}





$AppServicePlan = "LA-CL-APIPLAN-P3"
$Tier = "PremiumV2" 
$Size = "Medium"
$app=Get-AzureRmAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlan
$apps=Get-AzureRmWebApp -AppServicePlan $app

Set-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlan -Tier "$Tier" -WorkerSize "$Size"
Set-AzAppServicePlan -NumberofWorkers 1 -Name $AppServicePlan -ResourceGroupName $ResourceGroupName

Foreach($app in $apps)
{
 $websiteName = $app.Name
 Restart-AzureRmWebApp -ResourceGroupName $app.ResourceGroup -Name $websiteName
}





$AppServicePlan = "LA-CL-APIPLAN-P4-1"
$Tier = "PremiumV2" 
$Size = "Small"
$app=Get-AzureRmAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlan
$apps=Get-AzureRmWebApp -AppServicePlan $app

Set-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlan -Tier "$Tier" -WorkerSize "$Size"
Set-AzAppServicePlan -NumberofWorkers 1 -Name $AppServicePlan -ResourceGroupName $ResourceGroupName

Foreach($app in $apps)
{
 $websiteName = $app.Name
 Restart-AzureRmWebApp -ResourceGroupName $app.ResourceGroup -Name $websiteName
}




$AppServicePlan = "LA-CL-APIPLAN-P4"
$Tier = "PremiumV2" 
$Size = "Medium"
$app=Get-AzureRmAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlan
$apps=Get-AzureRmWebApp -AppServicePlan $app

Set-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlan -Tier "$Tier" -WorkerSize "$Size"
Set-AzAppServicePlan -NumberofWorkers 1 -Name $AppServicePlan -ResourceGroupName $ResourceGroupName

Foreach($app in $apps)
{
 $websiteName = $app.Name
 Restart-AzureRmWebApp -ResourceGroupName $app.ResourceGroup -Name $websiteName
}





$AppServicePlan = "LA-CL-APIPLAN-P5"
$Tier = "PremiumV2" 
$Size = "Small"
$app=Get-AzureRmAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlan
$apps=Get-AzureRmWebApp -AppServicePlan $app

Set-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlan -Tier "$Tier" -WorkerSize "$Size"
Set-AzAppServicePlan -NumberofWorkers 1 -Name $AppServicePlan -ResourceGroupName $ResourceGroupName

Foreach($app in $apps)
{
 $websiteName = $app.Name
 Restart-AzureRmWebApp -ResourceGroupName $app.ResourceGroup -Name $websiteName
}



