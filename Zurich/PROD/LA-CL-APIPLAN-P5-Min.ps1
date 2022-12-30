Set-AzContext -Subscription "251f8d88-2d55-4b29-bb93-c4feb93b3f8a"

$ResourceGroupName = "LA-CL-IaaS-Automation"
$AppServicePlan = "LA-CL-APIPLAN-P5"
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