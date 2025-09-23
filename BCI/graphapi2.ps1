# Autenticación con Microsoft Graph
Connect-MgGraph -Scopes "AuditLog.Read.All"

# Obtener eventos de auditoría relacionados con LAPS
$startDate = (Get-Date).AddDays(-30).ToString("yyyy-MM-ddTHH:mm:ssZ")
$endDate = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssZ")

# Usar operadores compatibles con OData - obtener todos los eventos primero
try {
    Write-Host "Obteniendo eventos de auditoría..." -ForegroundColor Yellow
    
    # Obtener eventos sin filtro específico de activityDisplayName (más confiable)
    $events = Get-MgAuditLogDirectoryAudit -Filter "activityDateTime ge $startDate and activityDateTime le $endDate" -All
    
    # Filtrar localmente por eventos relacionados con passwords
    $passwordEvents = $events | Where-Object { 
        $_.ActivityDisplayName -like "*password*" -or 
        $_.ActivityDisplayName -like "*LAPS*" -or
        $_.ActivityDisplayName -like "*local administrator*"
    }
    
    Write-Host "Total de eventos encontrados: $($events.Count)" -ForegroundColor Green
    Write-Host "Eventos relacionados con passwords: $($passwordEvents.Count)" -ForegroundColor Green
    
    # Exportar los eventos filtrados a un archivo CSV
    if ($passwordEvents.Count -gt 0) {
        $passwordEvents | #Select-Object ActivityDateTime, ActivityDisplayName, InitiatedBy, TargetResources | 
            Export-Csv -Path "./laps_audit_events.csv" -NoTypeInformation -Encoding UTF8
        Write-Host "Eventos exportados a: ./laps_audit_events.csv" -ForegroundColor Green
    } else {
        Write-Host "No se encontraron eventos relacionados con passwords." -ForegroundColor Yellow
    }
    
} catch {
    Write-Error "Error al obtener eventos de auditoría: $($_.Exception.Message)"
    # Alternativa: obtener todos los eventos recientes y filtrar
    # Write-Host "Intentando obtener eventos sin filtro de fecha..." -ForegroundColor Yellow
    # try {
    #     $allEvents = Get-MgAuditLogDirectoryAudit -Top 1000
    #     $passwordEvents = $allEvents | Where-Object { 
    #         $_.ActivityDisplayName -like "*password*" -or 
    #         $_.ActivityDisplayName -like "*LAPS*"
    #     }
        
    #     if ($passwordEvents.Count -gt 0) {
    #         $passwordEvents | Export-Csv -Path "./laps_audit_events.csv" -NoTypeInformation -Encoding UTF8
    #         Write-Host "Eventos exportados a: ./laps_audit_events.csv" -ForegroundColor Green
    #     }
    # } catch {
    #     Write-Error "Error alternativo: $($_.Exception.Message)"
    # }
}

# Desconectar de Graph
# Disconnect-MgGraph

 Export-Csv -Path "./laps_audit_events.csv" -NoTypeInformation -Encoding UTF8

 
$auditLogs = Get-MgAuditLogSignIn | Where-Object { $_.ActivityDisplayName -like "*LAPS*" }

$auditLogs | Export-Csv -Path "./laps_audit_logs_events.csv" -NoTypeInformation -Encoding UTF8
