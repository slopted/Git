# Variables de configuración
$workspaceId  = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" #Reemplazar con el Log Analytics Workspace ID
$clientId     = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" #Reemplazar con el Client ID del enterprise application con permisos sobre el RG de Contributor
$clientSecret = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" #Reemplazar con el Client Secret del enterprise application con permisos sobre el RG de Contributor
$tenantId     = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" #Reemplazar por el id del tenant



$query = @"
AuditLogs
| where ActivityDisplayName == "Recover device local Administrator password"
| project TimeGenerated, ActivityDisplayName, InitiatedBy.user.id, InitiatedBy.user.displayName, InitiatedBy.user.userPrincipalName, TargetResources.[0].displayName, TargetResources.[0].id
"@
 
# Credenciales de Azure SQL Database
$sqlServer = "monitoreo-logs.database.windows.net" #SQL Server URL
$sqlDatabase = "Monitoreo_Logs" #DataBase Name
$sqlUser = "sa" #Local SQL User (normalmente el sa)
$sqlPassword = "************" #Local SQL User's Password
$connectionString = "Server=$sqlServer;Database=$sqlDatabase;User Id=$sqlUser;Password=$sqlPassword;" 
 
# Autenticación a Log Analytics
$body = @{
    grant_type    = "client_credentials"
    client_id     = $clientId
    client_secret = $clientSecret
    resource      = "https://api.loganalytics.io"
}
$response = Invoke-RestMethod -Method Post -Uri "https://login.microsoftonline.com/$tenantId/oauth2/token" -ContentType "application/x-www-form-urlencoded" -Body $body
$token = $response.access_token
 
if ($token) {
    Write-Output "Autenticación exitosa. Token obtenido."
} else {
    Write-Error "Error en la autenticación. No se pudo obtener el token."
    exit
}
 
# Ejecutar la query de Log Analytics
$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type"  = "application/json"
}
$uri = "https://api.loganalytics.io/v1/workspaces/$workspaceId/query"
$body = @{ query = $query } | ConvertTo-Json
$response = Invoke-RestMethod -Method Post -Uri $uri -Headers $headers -Body $body
 
if ($response) {
    Write-Output "Query ejecutada exitosamente."
} else {
    Write-Error "Error al ejecutar la query."
    exit
}
 
# Procesar los resultados de la query
$results = $response.tables[0].rows
if ($results.Count -eq 0) {
    Write-Error "No se encontraron resultados en la query."
    exit
}

# Crear DataTable para Bulk Insert en Azure SQL Database
$dataTable = New-Object System.Data.DataTable
$dataTable.Columns.Add("TimeGenerated", [System.Type]::GetType("System.DateTime"))
$dataTable.Columns.Add("ActivityDisplayName", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("InitiatedBy_user_id", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("InitiatedBy_user_displayName", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("InitiatedBy_user_userPrincipalName", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("TargetResources_0_displayName", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("TargetResources_0_id", [System.Type]::GetType("System.String"))

 
foreach ($row in $results) {
    $dataRow = $dataTable.NewRow()
    $dataRow["TimeGenerated"] = [DateTime]::Parse($row[0])
    $dataRow["ActivityDisplayName"] = $row[1]
    $dataRow["InitiatedBy_user_id"] = $row[2]
    $dataRow["InitiatedBy_user_displayName"] = $row[3]
    $dataRow["InitiatedBy_user_userPrincipalName"] = $row[4]
    $dataRow["TargetResources_0_displayName"] = $row[5]
    $dataRow["TargetResources_0_id"] = $row[6]
    $dataTable.Rows.Add($dataRow)
}
 
# Conectar a Azure SQL Database
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
$connection.Open()
 
# Configurar el Bulk Insert
$bulkCopy = New-Object Data.SqlClient.SqlBulkCopy($connection)
$bulkCopy.DestinationTableName = "LogAnalyticsResults"
$bulkCopy.BatchSize = 1000
$bulkCopy.BulkCopyTimeout = 600
 
try {
    # Insertar los datos en la base de datos
    $bulkCopy.WriteToServer($dataTable)
    Write-Output "Bulk Insert completado exitosamente."
} catch {
    Write-Error "Error durante el Bulk Insert: $_"
} finally {
    $connection.Close()
}
