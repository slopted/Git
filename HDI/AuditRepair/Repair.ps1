Get-ADComputer -Filter {OperatingSystem -Like "*Server 2008*"} -Property * | Select-Object Name,OperatingSystem,OperatingSystemServicePack,OperatingSystemVersion, DistinguishedName, Enabled  | Export-Csv -Path "C:\Temp\Vul7.csv" -NoTypeInformation -Encoding UTF8 

Get-ADObject -Filter {UserAccountControl -band 0x200000 -or msDs-supportedEncryptionTypes -band 3}

Get-ADObject -Identity ((Get-ADDomain).distinguishedname) -Properties ms-DS-MachineAccountQuota