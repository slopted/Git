# Obtener la fecha límite (hace 60 días)
$fechaLimite = (Get-Date).AddDays(-60)

# 1. Contar cuentas de usuario desactivadas y exportar detalles a CSV con todos los atributos
$usuariosDesactivados = Get-ADUser -Filter 'Enabled -eq $false' -Properties *
Write-Host "Usuarios desactivados: $($usuariosDesactivados.Count)"
$usuariosDesactivados | Select-Object * | Export-Csv -Path "C:\temp\usuarios_desactivados.csv" -NoTypeInformation -Encoding UTF8 -Delimiter ';'

# 2. Cuentas activas que no han iniciado sesión en 60 días
$usuariosInactivos = Get-ADUser -Filter 'Enabled -eq $true' -Properties * | Where-Object {
    !$_.LastLogonDate -or $_.LastLogonDate -lt $fechaLimite
}
Write-Host "Usuarios activos sin login en 60 días: $($usuariosInactivos.Count)"
$usuariosInactivos | Select-Object * | Export-Csv -Path "C:\temp\usuarios_activos_inactivos.csv" -NoTypeInformation -Encoding UTF8 -Delimiter ';'

# 3. Objetos máquina activos que no han iniciado sesión en 60 días
$maquinasInactivas = Get-ADComputer -Filter 'Enabled -eq $true' -Properties *
$maquinasInactivas = $maquinasInactivas | Where-Object {
    !$_.LastLogonDate -or $_.LastLogonDate -lt $fechaLimite
}
Write-Host "Máquinas activas sin login en 60 días: $($maquinasInactivas.Count)"
$maquinasInactivas | Select-Object * | Export-Csv -Path "C:\temp\maquinas_activas_inactivas.csv" -NoTypeInformation -Encoding UTF8 -Delimiter ';'

# 4. Generar un informe resumen en HTML con enlaces a los CSV exportados

$reporteHtml = @"
<html>
<head>
    <title>Informe de Cuentas y Equipos Inactivos</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { border-collapse: collapse; width: 60%; margin-bottom: 20px; }
        th, td { border: 1px solid #dddddd; text-align: left; padding: 8px; }
        th { background-color: #f2f2f2; }
        h2 { color: #2e6c80; }
    </style>
</head>
<body>
    <h1>Informe de Cuentas y Equipos Inactivos</h1>
    <p>Generado por: Consultor Senior de TI</p>
    <p>Fecha de generación: $(Get-Date -Format "yyyy-MM-dd HH:mm")</p>
    <h2>Resumen</h2>
    <table>
        <tr>
            <th>Tipo</th>
            <th>Cantidad</th>
            <th>Detalle</th>
        </tr>
        <tr>
            <td>Usuarios desactivados</td>
            <td>$($usuariosDesactivados.Count)</td>
            <td><a href="C:\temp\usuarios_desactivados.csv">Descargar CSV</a></td>
        </tr>
        <tr>
            <td>Usuarios activos sin login en 60 días</td>
            <td>$($usuariosInactivos.Count)</td>
            <td><a href="C:\temp\usuarios_activos_inactivos.csv">Descargar CSV</a></td>
        </tr>
        <tr>
            <td>Máquinas activas sin login en 60 días</td>
            <td>$($maquinasInactivas.Count)</td>
            <td><a href="C:\temp\maquinas_activas_inactivas.csv">Descargar CSV</a></td>
        </tr>
    </table>
    <p>Este informe fue generado automáticamente para su revisión y acciones correspondientes.</p>
</body>
</html>
"@

$reporteHtml | Set-Content -Path "C:\temp\informe_resumen.html" -Encoding UTF8
Write-Host "Informe resumen exportado a C:\temp\informe_resumen.html"