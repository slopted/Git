Search-ADAccount –AccountInActive  –ComputersOnly –TimeSpan 180:00:00:00 –ResultPageSize 5000 –ResultSetSize $null | ?{$_.Enabled –eq $True} | Select-Object Name, SamAccountName, DistinguishedNama, operatingSystem, OperatingSystemServicePack, OperatingSystemVersion | Export-Csv -Path "C:\Temp\Vul1.csv" -NoTypeInformation -Encoding UTF8
Get-ADComputer -Filter { operatingsystem -like "*Server 2003*" } -Property * | Select-Object Name, OperatingSystem, OperatingSystemServicePack, OperatingSystemVersion, DistinguishedName, Enabled  | Export-Csv -Path "C:\Temp\Vul2.csv" -NoTypeInformation -Encoding UTF8
get-adobject -ldapfilter "(&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=32))" -properties useraccountcontrol | Export-Csv -Path "C:\Temp\Vul5.csv" -NoTypeInformation -Encoding UTF8
Get-ADObject -Filter {UserAccountControl -band 0x200000 -or msDs-supportedEncryptionTypes -band 3} | Export-Csv -Path "C:\Temp\Vul6.csv" -NoTypeInformation -Encoding UTF8
get-adobject -ldapfilter "(admincount=1)"



 #| where {$_.enabled -eq $true}




Get-ADComputer -Filter {OperatingSystem -Like "*Server 2008*"} -Property * | Select-Object Name,OperatingSystem,OperatingSystemServicePack,OperatingSystemVersion, DistinguishedName, Enabled  | Export-Csv -Path "C:\Temp\Vul7.csv" -NoTypeInformation -Encoding UTF8 
You can replace -Filter * with -Filter {OperatingSystem -Like "Windows Server*"}


Get-ADComputer -Filter {OperatingSystem -Like "*Windows 10*" } -Property Name,OperatingSystem,OperatingSystemServicePack,OperatingSystemVersion, DistinguishedName, Enabled | Select-Object Name,OperatingSystem,OperatingSystemServicePack,OperatingSystemVersion, DistinguishedName, Enabled  | Export-Csv -Path "C:\Temp\Vul10.csv" -NoTypeInformation -Encoding UTF8
Get-ADComputer -Filter {OperatingSystem -Like "*Windows 11*" } -Property Name,OperatingSystem,OperatingSystemServicePack,OperatingSystemVersion, DistinguishedName, Enabled | Select-Object Name,OperatingSystem,OperatingSystemServicePack,OperatingSystemVersion, DistinguishedName, Enabled  | Export-Csv -Path "C:\Temp\Vul10_!.csv" -NoTypeInformation -Encoding UTF8


-or OperatingSystem -Like "*Windows 11*"

Get-ADComputer -Filter {OperatingSystem -Like "*Server 2012*"} -Property Name,OperatingSystem,OperatingSystemServicePack,OperatingSystemVersion, DistinguishedName, Enabled | Select-Object Name,OperatingSystem,OperatingSystemServicePack,OperatingSystemVersion, DistinguishedName, Enabled  | Export-Csv -Path "C:\Temp\Vul12.csv" -NoTypeInformation -Encoding UTF8 
