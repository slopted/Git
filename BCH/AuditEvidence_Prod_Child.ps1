##VUL_01##
Get-ADComputer -Filter { operatingsystem -like "*Server 2003*" } -Property * | Select-Object Name, OperatingSystem, OperatingSystemServicePack, OperatingSystemVersion, DistinguishedName, Enabled  | Export-Csv -Path "C:\Temp\VulProdChild01.csv" -NoTypeInformation -Encoding UTF8
##VUL_02##
Get-ADComputer -Filter { operatingsystem -like "*Server 2008*" } -Property * | Select-Object Name, OperatingSystem, OperatingSystemServicePack, OperatingSystemVersion, DistinguishedName, Enabled  | Export-Csv -Path "C:\Temp\VulProdChild02.csv" -NoTypeInformation -Encoding UTF8
##VUL_04##
Get-ADComputer -Filter {(Enabled -eq $true) -and (OperatingSystem -Like "*Windows XP*")} -Property * | Select-Object Name, OperatingSystem, OperatingSystemServicePack, OperatingSystemVersion, DistinguishedName, Enabled | Export-Csv -Path "C:\Temp\VulProdChild04.csv" -NoTypeInformation -Encoding UTF8
##VUL_09##
Get-ADComputer -Filter {(Enabled -eq $true) -and (OperatingSystem -Like "*Windows 10*")} -Property * | Select-Object Name, OperatingSystem, OperatingSystemServicePack, OperatingSystemVersion, DistinguishedName, Enabled | Export-Csv -Path "C:\Temp\VulProdChild09_1.csv" -NoTypeInformation -Encoding UTF8
Get-ADComputer -Filter {(Enabled -eq $true) -and (OperatingSystem -Like "*Windows 11*")} -Property * | Select-Object Name, OperatingSystem, OperatingSystemServicePack, OperatingSystemVersion, DistinguishedName, Enabled | Export-Csv -Path "C:\Temp\VulProdChild09_2.csv" -NoTypeInformation -Encoding UTF8
##VUL_10##
Get-ADComputer -Filter { operatingsystem -like "*Server 2012*" } -Property * | Select-Object Name, OperatingSystem, OperatingSystemServicePack, OperatingSystemVersion, DistinguishedName, Enabled  | Export-Csv -Path "C:\Temp\VulProdChild10.csv" -NoTypeInformation -Encoding UTF8
##VUL_14##
Get-ADComputer -Filter {(Enabled -eq $true) -and (OperatingSystem -Like "*Windows 7*")} -Property * | Select-Object Name, OperatingSystem, OperatingSystemServicePack, OperatingSystemVersion, DistinguishedName, Enabled | Export-Csv -Path "C:\Temp\VulProdChild14.csv" -NoTypeInformation -Encoding UTF8