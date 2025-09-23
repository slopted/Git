# Autenticación con Microsoft Graph
Connect-MgGraph -Scopes "AuditLog.Read.All"

# Obtener eventos de auditoría relacionados con LAPS
$startDate = (Get-Date).AddDays(-360).ToString("yyyy-MM-ddTHH:mm:ssZ")
$endDate = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssZ")

#$events = Get-MgAuditLogDirectoryAudit -Filter "contains(activityDisplayName, 'local administrator password') and activityDateTime ge $startDate and activityDateTime le $endDate"

$events = Get-MgAuditLogDirectoryAudit -Filter "contains(activityDisplayName,'password')" 


# Mostrar detalles
# $events | Select-Object activityDateTime, initiatedBy, targetResources


# Exportar los eventos a un archivo CSV
$events | Export-Csv -Path "./laps_audit_events.csv" -NoTypeInformation -Encoding UTF8