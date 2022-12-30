####-----> Colocar RG correcto 
$ResourceGroupName = "rg_zurich_lab"

####-----> Colocar AppServicePlan correcto 
$AppServicePlan = "ASP-rgzurichlab-b9e3"

####-----> Colocar el Tier requerido para escalamiento vertical
$Tier = "Free" 

####-----> Colocar el Size requerido para escalamiento vertical
$Size = "Small"

####-----> Cambio de plan de escalamiento vertical
Set-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlan -Tier "$Tier" -WorkerSize "$Size"

####-----> Apaga y Enciende Aplicaciones para replicar escalamiento
$app=Get-AzureRmAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlan

$apps=Get-AzureRmWebApp -AppServicePlan $app

Foreach($app in $apps)
{
 $websiteName = $app.Name
 Restart-AzureRmWebApp -ResourceGroupName $app.ResourceGroup -Name $websiteName
}

####-----> Cambiar número de instancias requeridas en "NumberofWorkers" para escalamiento horizontal
Set-AzAppServicePlan -NumberofWorkers 2 -Name $AppServicePlan -ResourceGroupName $ResourceGroupName