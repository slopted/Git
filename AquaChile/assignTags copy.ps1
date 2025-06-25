# Note:
# Ensure you have the Azure CLI installed and are logged in
# Ensure you have the necessary permissions to modify resource groups

# Connect to Azure interactively with your user account
az login

# List of Subscriptions
$Subscription = @(
    "sub-prd-001",
    "sub-connectivity-001",
    "sub-dev-001"
)

# List of Resource Groups
$RG_Prod = @(
    "synapseworkspace-managedrg-4786828f-8845-491a-8fe6-0c8ba5691924",
    "rg-prd-trafficmanager-eus2",
    "rg-prd-tecnoandina-eus2",
    "rg-prd-sistemagestionti-eus2",
    "rg-prd-sensoresiot-eus2",
    "rg-prd-semanalweb-eus2",
    "rg-prd-sapc4c-eus2",
    "rg-prd-rpalecturacv-eus",
    "rg-prd-respaldosvms-eus2",
    "rg-prd-networking-eastus2",
    "rg-prd-monitoring",
    "rg-prd-geneticaproduccion-eus2",
    "rg-prd-factorcondicion-eus2",
    "rg-prd-evaluacioncalidadfiletes-eus2",
    "rg-prd-easm-eus",
    "rg-prd-dns-eus2",
    "rg-prd-diagnosticonecropsia-eus2",
    "rg-prd-datalake-fabric-eus2",
    "rg-prd-datalake-eus2",
    "rg-prd-bioseguridad-eus2",
    "rg-prd-aquaorigen-eus2",
    "rg-prd-apigateway-eus2",
    "rg-prd-analiticaciberseguridad-eus2",
    "rg-iaas-aks-prod",
    "networkwatcherrg",
    "mc_rg-prd-apigateway-eus2_aks-prd-api-eus2_eastus2",
    "loganalyticsdefaultresources",
    "defaultresourcegroup-eus2",
    "crearpruebba",
    "azurebackuprg_eastus2_1"
)

# Additional Resource Groups
$RG_Dev = @(
    "rg-dev-riesgoscorporativos-eus2",
    "rg-dev-productosdigitales-eus2",
    "rg-dev-networking-eastus2",
    "rg-dev-datalake-eus2",
    "networkwatcherrg",
    "mng-rg-synw-dev-datalake-eus2"
)

# Additional Hub Resource Groups
$RG_Connectivity = @(
    "rg-hub-respaldosvms-eastus2",
    "rg-hub-networking-eastus2",
    "rg-hub-fortigate-eastus2",
    "rg-hub-dnsprivado-eastus2",
    "networkwatcherrg"
)

# Create a dictionary to map subscriptions to their respective resource groups
$SubscriptionResourceGroups = @{
    "sub-prd-001"         = $RG_Prod
    "sub-dev-001"         = $RG_Dev
    "sub-connectivity-001" = $RG_Connectivity
}


foreach ($subscriptionId in $Subscription) {
    try {
        # Set the current subscription context
        az account set --subscription $subscriptionId
        Write-Host "Logged in to subscription: $subscriptionId" -ForegroundColor Yellow

        # Get the resource groups for this subscription from the dictionary
        $RG = $SubscriptionResourceGroups[$subscriptionId]

        if ($null -ne $RG) {
            foreach ($resourceGroup in $RG) {
                try {
                    # Assign tags using az CLI
                    az group update --resource-group $resourceGroup --tags Gerencia=Gerencia Area=Area SubArea=SubArea Ceco=Ceco Iniciativa=Iniciativa ResponsableNegocio=ResponsableNegocio Criticidad=Criticidad Aprobador=Aprobador TipoDesarrollo=TipoDesarrollo ResponsableTi=ResponsableTi Ambiente=Ambiente NombreAplicacion=NombreAplicacion NombreSoporte=NombreSoporte ClasificacionData=ClasificacionData Presupuesto=Presupuesto Descripcion=Descripcion FechaCreacion=FechaCreacion FechaTermino=FechaTermino
                    Write-Host "Tags assigned to Resource Group: $resourceGroup" -ForegroundColor Green
                } catch {
                    Write-Host "Failed to assign tags to Resource Group: $resourceGroup. Error: $_" -ForegroundColor Red
                }
            }
        } else {
            Write-Host "No resource groups found for subscription: $subscriptionId" -ForegroundColor DarkYellow
        }
    } catch {
        Write-Host "Failed to switch to subscription: $subscriptionId. Error: $_" -ForegroundColor Red
    }
}

# End of script
