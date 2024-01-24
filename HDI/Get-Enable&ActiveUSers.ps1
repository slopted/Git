$DaysInactive = 180
$time = (Get-Date).Adddays(-($DaysInactive))

#Export Active Computers#
Get-ADComputer -Filter {LastLogonTimeStamp -gt $time} -ResultPageSize 2000 -resultSetSize $null -Properties Name, OperatingSystem, SamAccountName, DistinguishedName, LastLogonDate | Export-CSV "C:\Temp\ActiveComp.csv" -NoTypeInformation
#Export Enabled Computers#
Get-ADComputer -Filter {Enabled -eq 'True'} -ResultPageSize 2000 -resultSetSize $null -Properties Name, OperatingSystem, SamAccountName, DistinguishedName, LastLogonDate | Export-CSV "C:\Temp\EnabledComp.csv" -NoTypeInformation
#Export All Computers#
get-adcomputer -filter * -properties Name, OperatingSystem, SamAccountName, DistinguishedName, LastLogonDate | Export-CSV "C:\Temp\CompAll.csv" -NoTypeInformation
