$global:scriptPath = $myinvocation.mycommand.definition

function Restart-AsAdmin {
    $pwshCommand = "powershell"
    if ($PSVersionTable.PSVersion.Major -ge 6) {
        $pwshCommand = "pwsh"
    }

    try {
        Write-Host "This script requires administrator permissions to uninstall the Azure Connected Machine Agent. Attempting to restart script with elevated permissions..."
        $arguments = "-NoExit -Command `"& '$scriptPath'`"" 
        Start-Process $pwshCommand -Verb runAs -ArgumentList $arguments
        exit 0
    } catch {
        throw "Failed to elevate permissions. Please run this script as Administrator."
    }
}

try {
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        if ([System.Environment]::UserInteractive) {
            Restart-AsAdmin
        } else {
            throw "This script requires administrator permissions to uninstall the Azure Connected Machine Agent. Please run this script as Administrator."
        }
    }

 # Add the service principal application ID and secret here
 $ServicePrincipalId="4ceceeba-463a-470a-9974-3e3d9c8c6cd0";
 $ServicePrincipalClientSecret="";

 $env:SUBSCRIPTION_ID = "5354456f-0232-435c-af4f-15b64e77c1cb";
 $env:RESOURCE_GROUP = "BCIRG3POC-RG-LPS001";
 $env:TENANT_ID = "2fb79105-8354-42f6-a589-c38e0ec918ab";
 $env:LOCATION = "eastus2";
 $env:AUTH_TYPE = "principal";
 $env:CORRELATION_ID = "312fd791-4acd-4596-a92b-e752bdda54d3";
 $env:CLOUD = "AzureCloud";


    # Uninstall the hybrid agent -including Azure
    & "$env:ProgramW6432\AzureConnectedMachineAgent\azcmagent.exe" disconnect --service-principal-id "$ServicePrincipalId" --service-principal-secret "$ServicePrincipalClientSecret";
    if ($LASTEXITCODE -ne 0) { exit 1; }
    
     # Uninstall the hybrid agent - locally
     & "$env:ProgramW6432\AzureConnectedMachineAgent\azcmagent.exe" azcmagent disconnect --force-local-only;
     if ($LASTEXITCODE -ne 0) { exit 1; }
    
    # Remove the agent
    & "$env:ProgramW6432\AzureConnectedMachineAgent\azcmagent.exe" uninstall;
    if ($LASTEXITCODE -ne 0) { exit 1; }

    # Clean up environment variables
    Remove-Item Env:SUBSCRIPTION_ID
    Remove-Item Env:RESOURCE_GROUP
    Remove-Item Env:TENANT_ID
    Remove-Item Env:LOCATION
    Remove-Item Env:AUTH_TYPE
    Remove-Item Env:CORRELATION_ID
    Remove-Item Env:CLOUD

    Write-Host "Azure Connected Machine Agent uninstalled successfully."
}
catch {
    $logBody = @{subscriptionId="$env:SUBSCRIPTION_ID";resourceGroup="$env:RESOURCE_GROUP";tenantId="$env:TENANT_ID";location="$env:LOCATION";correlationId="$env:CORRELATION_ID";authType="$env:AUTH_TYPE";operation="offboarding";messageType=$_.FullyQualifiedErrorId;message="$_";};
    Invoke-WebRequest -UseBasicParsing -Uri "https://gbl.his.arc.azure.com/log" -Method "PUT" -Body ($logBody | ConvertTo-Json) | out-null;
    Write-Host  -ForegroundColor red $_.Exception;
}

/*DOCUMENTATION
Este script realiza las siguientes acciones:

Verifica si el script se está ejecutando con permisos de administrador y, si no, intenta reiniciarlo con permisos elevados.
Desconecta de azure, desconecta localmente y desinstala el agente de Azure Connected Machine.
Elimina las variables de entorno establecidas durante la instalación.
Registra cualquier error que ocurra durante el proceso de desinstalación.
Asegúrate de probar el script en un entorno de desarrollo antes de ejecutarlo en producción.
*/