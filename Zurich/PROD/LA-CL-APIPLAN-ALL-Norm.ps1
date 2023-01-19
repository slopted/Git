Set-AzContext -Subscription "681b3fc7-7337-4919-8063-586130a56c9f"

$ResourceGroupName = "LA-CL-APPS-SOAP"
#"LA-CL-APP-PLAN-P1"
$AppServicePlan = "LA-CL-APP-PLAN-P1"
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


#"LA-CL-APP-PLAN-P2"
$AppServicePlan = "LA-CL-APP-PLAN-P2"
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


#"LA-CL-APP-PLAN-P3-1"
$AppServicePlan = "LA-CL-APP-PLAN-P3-1"
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


#"LA-CL-APP-PLAN-P3"
$AppServicePlan = "LA-CL-APP-PLAN-P3"
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


#"LA-CL-APP-PLAN-P4"
$AppServicePlan = "LA-CL-APP-PLAN-P4"
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


#"LA-CL-APP-PLAN-P5"
$AppServicePlan = "LA-CL-APP-PLAN-P5"
$Tier = "Standard" 
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


Start-Sleep -Seconds 120
Get-AzureRmWebApp | Select-Object name,state