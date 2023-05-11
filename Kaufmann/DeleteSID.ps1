##USERS##
Import-Csv C:\Temp\530.csv -Delimiter ',' -Encoding UTF7 | ForEach-Object {
    
    #variabes csv
    $Name = $_."SamAccountName"
    $SIDHistory = $_."SIDHistory"
        
    ##seteos
    Get-ADUser -Identity $Name -Properties SidHistory | Select-Object -ExpandProperty SIDHistory
    #Set-ADUser -Identity $Name -Remove @{SIDHistory=$SIDHistory}
}


##GROUPS##
Import-Csv C:\Temp\618-2.csv -Delimiter ',' -Encoding UTF7 | ForEach-Object {
    
    #variabes csv
    $Group = $_."SamAccountName"
    $SIDHistory2 = $_."SIDHistory"
        
    ##seteos
    Get-ADGroup -Identity $Group -Properties SidHistory | Select-Object -ExpandProperty SIDHistory
    #Set-ADGroup -Identity $Group -Remove @{SIDHistory=$SIDHistory2}
}