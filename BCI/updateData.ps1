# Variables de configuración
$workspaceId  = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" #Reemplazar con el Log Analytics Workspace ID
$clientId     = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" #Reemplazar con el Client ID del enterprise application con permisos sobre el RG de Contributor
$clientSecret = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" #Reemplazar con el Client Secret del enterprise application con permisos sobre el RG de Contributor
$tenantId     = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" #Reemplazar por el id del tenant
$query = @"
Event
| where EventID==4624 or EventID==4634 or EventID==4657 or EventID==4674 or EventID==4688 or EventID==4697 or EventID==4698 or EventID==4699 or EventID==4700 or EventID==4701 or EventID==4702 or EventID==4720 or EventID==4722 or EventID==4724 or EventID==4725 or EventID==4726 or EventID==4728 or EventID==4731 or EventID==4732 or EventID==4734 or EventID==4735 or EventID==5142
| where TimeGenerated >= startofday(datetime_add('day', -100, now())) and TimeGenerated < startofday(now())
| extend LogonType = extract('<Data Name="LogonType">(.+?)</Data>', 1, tostring(EventData))
| extend IpAddress = extract('<Data Name="IpAddress">(.+?)</Data>', 1, tostring(EventData))
| extend TargetUserName = extract('<Data Name="TargetUserName">(.+?)</Data>', 1, tostring(EventData))
| extend TargetDomainName = extract('<Data Name="TargetDomainName">(.+?)</Data>', 1, tostring(EventData))
| extend SubjectUserName = extract('<Data Name="SubjectUserName">(.+?)</Data>', 1, tostring(EventData))
| extend SubjectDomainName = extract('<Data Name="SubjectDomainName">(.+?)</Data>', 1, tostring(EventData))
| extend ProcessName = extract('<Data Name="ProcessName">(.+?)</Data>', 1, tostring(EventData))
| extend ObjectName = extract('<Data Name="ObjectName">(.+?)</Data>', 1, tostring(EventData))
| extend ObjectValueName = extract('<Data Name="ObjectValueName">(.+?)</Data>', 1, tostring(EventData))
| extend OldValue = extract('<Data Name="OldValue">(.+?)</Data>', 1, tostring(EventData))
| extend NewValue = extract('<Data Name="NewValue">(.+?)</Data>', 1, tostring(EventData))
| extend NewProcessName = extract('<Data Name="NewProcessName">(.+?)</Data>', 1, tostring(EventData))
| extend ServiceName = extract('<Data Name="ServiceName">(.+?)</Data>', 1, tostring(EventData))
| extend ServiceFileName = extract('<Data Name="ServiceFileName">(.+?)</Data>', 1, tostring(EventData))
| extend ServiceType = extract('<Data Name="ServiceType">(.+?)</Data>', 1, tostring(EventData))
| extend ServiceTypeName = case(
    ServiceType == "0x1", "Kernel Driver",
    ServiceType == "0x2", "File System Driver",
    ServiceType == "0x8", "Recognizer Driver",
    ServiceType == "0x10", "Win32 Own Process",
    ServiceType == "0x20", "Win32 Share Process",
    ServiceType == "0x110", "Interactive Own Process",
    ServiceType == "0x120", "Interactive Share Process",
    "Unknown"
)
| extend ServiceStartType = extract('<Data Name="ServiceStartType">(.+?)</Data>', 1, tostring(EventData))
| extend ServiceStartTypeName = case(
    ServiceStartType == "0", "Boot",
    ServiceStartType == "1", "System",
    ServiceStartType == "2", "Automatic or  Automatic|Delayed",
    ServiceStartType == "3", "Manual",
    ServiceStartType == "4", "Disabled",
    "Unknown"
)
| extend ServiceAccount = extract('<Data Name="ServiceAccount">(.+?)</Data>', 1, tostring(EventData))
| extend TaskName = extract('<Data Name="TaskName">(.+?)</Data>', 1, tostring(EventData))
| extend MemberSid = extract('<Data Name="MemberSid">(.+?)</Data>', 1, tostring(EventData))
| extend MemberName = extract('<Data Name="MemberName">(.+?)</Data>', 1, tostring(EventData))
| extend ShareName = extract('<Data Name="ShareName">(.+?)</Data>', 1, tostring(EventData))
| extend ShareLocalPath = extract('<Data Name="ShareLocalPath">(.+?)</Data>', 1, tostring(EventData))
| extend NewProcessId = extract('<Data Name="NewProcessId">(.+?)</Data>', 1, tostring(EventData))
| extend NewProcessName = extract('<Data Name="NewProcessName">(.+?)</Data>', 1, tostring(EventData))
| extend TokenElevationType = extract('<Data Name="TokenElevationType">(.+?)</Data>', 1, tostring(EventData))
| extend TokenElevationTypeName = case(
    TokenElevationType == "%%1936", "Type 1 is a full token with no privileges removed or groups disabled.",
    TokenElevationType == "%%1937", "Type 2 is an elevated token with no privileges removed or groups disabled.",
    TokenElevationType == "%%1938", "Type 3 is a limited token with administrative privileges removed and administrative groups disabled.",
    "Unknown"
)
| extend ProcessId = extract('<Data Name="ProcessId">(.+?)</Data>', 1, tostring(EventData))
| extend LogonTypeName = case(
    LogonType == "2", "Interactive",
    LogonType == "3", "Network",
    LogonType == "4", "Batch",
    LogonType == "5", "Service",
    LogonType == "7", "Unlock",
    LogonType == "8", "NetworkCleartext",
    LogonType == "9", "NewCredentials",
    LogonType == "10", "RemoteInteractive",
    LogonType == "11", "CachedInteractive",
    "Unknown"
)
| extend EventDescription = case(
    EventID == "4624", "An account was successfully logged on",
    EventID == "4634", "An account was logged off",
    EventID == "4657", "A registry value modified",
    EventID == "4674", "An operation was attempted on a privileged object",
    EventID == "4688", "A new process has been created",
    EventID == "4697", "A service was installed in the system",
    EventID == "4698", "A scheduled task was created ",
    EventID == "4699", "A scheduled task was deleted",
    EventID == "4700", "A scheduled task enabled",
    EventID == "4701", "A scheduled task disabled",
    EventID == "4702", "A scheduled task updated",
    EventID == "4720", "A user account was created",
    EventID == "4722", "A user account was enabled",
    EventID == "4724", "An attempt was made to reset an account's password.",
    EventID == "4725", "A user account was disabled",
    EventID == "4726", "A user account was deleted",
    EventID == "4728", "A member was added to a group",
    EventID == "4731", "A security-enabled local group was created.",
    EventID == "4732", "A member was added to a security-enabled global group",
    EventID == "4734", "A security-enabled local group was deleted.",
    EventID == "4735", "A group was changed",
    EventID == "5142", "A network share object was added.",
    "Unknown"
)
| extend EventCategory = case(
    EventID == "4624", "Logon/Logoff",
    EventID == "4634", "Logon/Logoff",
    EventID == "4657", "System Integrity",
    EventID == "4674", "Sensitive Privilege",
    EventID == "4688", "Detailed Tracking",
    EventID == "4697", "Service Change",
    EventID == "4698", "Scheduled Tasks",
    EventID == "4699", "Scheduled Tasks",
    EventID == "4700", "Scheduled Tasks",
    EventID == "4701", "Scheduled Tasks",
    EventID == "4702", "Scheduled Tasks",
    EventID == "4720", "Account Management",
    EventID == "4722", "Account Management",
    EventID == "4724", "Account Management",
    EventID == "4725", "Account Management",
    EventID == "4726", "Account Management",
    EventID == "4728", "Security Group Management",
    EventID == "4731", "Security Group Management",
    EventID == "4732", "Security Group Management",
    EventID == "4734", "Security Group Management",
    EventID == "4735", "Security Group Management",
    EventID == "5142", "File Share",
    "Unknown"
)
| project TimeGenerated, EventID, EventDescription, EventCategory, LogonType, LogonTypeName, IpAddress, TargetUserName, TargetDomainName, SubjectUserName, SubjectDomainName, ProcessName, ObjectName, ObjectValueName, OldValue, NewValue, NewProcessId, NewProcessName, TokenElevationType, TokenElevationTypeName, ServiceName, ServiceFileName, ServiceType, ServiceTypeName,ServiceStartType, ServiceStartTypeName, ServiceAccount, TaskName,  ProcessId, MemberSid, MemberName, ShareName, ShareLocalPath
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
$dataTable.Columns.Add("EventID", [System.Type]::GetType("System.Int32"))
$dataTable.Columns.Add("EventDescription", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("EventCategory", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("LogonType", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("LogonTypeName", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("IpAddress", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("TargetUserName", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("TargetDomainName", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("SubjectUserName", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("SubjectDomainName", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("ProcessName", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("ObjectName", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("ObjectValueName", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("OldValue", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("NewValue", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("NewProcessId", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("NewProcessName", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("TokenElevationType", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("TokenElevationTypeName", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("ServiceName", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("ServiceFileName", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("ServiceType", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("ServiceTypeName", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("ServiceStartType", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("ServiceStartTypeName", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("ServiceAccount", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("TaskName", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("ProcessId", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("MemberSid", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("MemberName", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("ShareName", [System.Type]::GetType("System.String"))
$dataTable.Columns.Add("ShareLocalPath", [System.Type]::GetType("System.String"))

 
foreach ($row in $results) {
    $dataRow = $dataTable.NewRow()
    $dataRow["TimeGenerated"] = [DateTime]::Parse($row[0])
    $dataRow["EventID"] = [int]$row[1]
    $dataRow["EventDescription"] = $row[2]
    $dataRow["EventCategory"] = $row[3]
    $dataRow["LogonType"] = $row[4]
    $dataRow["LogonTypeName"] = $row[5]
    $dataRow["IpAddress"] = $row[6]
    $dataRow["TargetUserName"] = $row[7]
    $dataRow["TargetDomainName"] = $row[8]
    $dataRow["SubjectUserName"] = $row[9]
    $dataRow["SubjectDomainName"] = $row[10]
    $dataRow["ProcessName"] = $row[11]
    $dataRow["ObjectName"] = $row[12]
    $dataRow["ObjectValueName"] = $row[13]
    $dataRow["OldValue"] = $row[14]
    $dataRow["NewValue"] = $row[15]
    $dataRow["NewProcessId"] = $row[16]
    $dataRow["NewProcessName"] = $row[17]
    $dataRow["TokenElevationType"] = $row[18]
    $dataRow["TokenElevationTypeName"] = $row[19]
    $dataRow["ServiceName"] = $row[20]
    $dataRow["ServiceFileName"] = $row[21]
    $dataRow["ServiceType"] = $row[22]
    $dataRow["ServiceTypeName"] = $row[23]
    $dataRow["ServiceStartType"] = $row[24]
    $dataRow["ServiceStartTypeName"] = $row[25]
    $dataRow["ServiceAccount"] = $row[26]
    $dataRow["TaskName"] = $row[27]
    $dataRow["ProcessId"] = $row[28]
    $dataRow["MemberSid"] = $row[29]
    $dataRow["MemberName"] = $row[30]
    $dataRow["ShareName"] = $row[31]
    $dataRow["ShareLocalPath"] = $row[32]
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
