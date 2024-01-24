# Split pathT
$Path = Split-Path -Parent “C:\Temp\GetComputers\*.*”

# Create variable for the date stamp in log file
$LogDate = Get-Date -f yyyyMMddhhmm

# Define CSV and log file location variables
# They have to be on the same location as the script
$Csvfile = $Path + “\AllADComputers_$logDate.csv”

# Import Active Directory module
Import-Module ActiveDirectory

# Set distinguishedName as searchbase, you can use one OU or multiple OUs
# Or use the root domain like DC=infoalias,DC=local
$DNs = @(
“DC=infoalias,dc=local”
)

# Create empty array
$AllADComputers = @()

# Loop through every DN
foreach ($DN in $DNs) {
$Computers = Get-ADComputer -SearchBase $DN -Filter * -Properties *

# Add users to array
$AllADComputers += $Computers
}

# Create list
$AllADComputers | Sort-Object Name | Select-Object `
@{Label = “Nombre”; Expression = { $_.Name } },
@{Label = “Service Principal Name”; Expression = { $_.servicePrincipalName } },
@{Label = “Sistema Operativo”; Expression = { $_.OperatingSystem } },
@{Label = “Ipv4”; Expression = { $_.ipv4Address } },
@{Label = “Distinguished Name”; Expression = { $_.distinguishedName } },
@{Label = “When Created”; Expression = { $_.whencreated } },
@{Label = “Computer status”; Expression = { if (($_.Enabled -eq ‘TRUE’) ) { ‘Enabled’ } Else { ‘Disabled’ } } },
@{Label = “Last logon date”; Expression = { $_.lastlogondate } }|

# Export report to CSV file
Export-Csv -Encoding UTF8 -Path $Csvfile -NoTypeInformation #-Delimiter “;”



Get-ADComputer -filter * -properties * -ResultSetSize 99999999 | Select-Object Name, servicePrincipalName, OperatingSystem, distinguishedName, Enabled, lastlogondate | Export-CSV -path C:\temp\GetComputers\AllADComputers.csv

#Name, servicePrincipalName, OperatingSystem, ipv4Address,distinguishedName, whencreated, Enabled, lastlogondate