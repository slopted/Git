Get-ADGroupMember "Domain Admins" | Export-CSV C:\Temp\ExportDA.csv -notypeinformation -Encoding UTF7


Import-Csv C:\Temp\ExportDA.csv -Delimiter ',' -Encoding UTF7 | ForEach-Object {
    
    #variabes csv
    $Name = $_."SamAccountName"
    #$SIDHistory = $_."SIDHistory"
        
    ##seteos}
    Get-ADUser -Identity $Name -Properties AccountNotDelegated #| Where-Object { $_.AccountNotDelegated -and  $_.objectClass -eq "user" }#-and  $_.displayName -match '.*\wOff'}
    #| Select-Object -ExpandProperty SIDHistory
    #Set-ADUser -Identity $Name -AccountNotDelegated $true
}