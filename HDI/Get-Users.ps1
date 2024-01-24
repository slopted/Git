# Split pathT
$Path = Split-Path -Parent “C:\Temp\GetUsers\*.*”

# Create variable for the date stamp in log file
$LogDate = Get-Date -f yyyyMMddhhmm

# Define CSV and log file location variables
# They have to be on the same location as the script
$Csvfile = $Path + “\AllADUsers_$logDate.csv”

# Import Active Directory module
Import-Module ActiveDirectory

# Set distinguishedName as searchbase, you can use one OU or multiple OUs
# Or use the root domain like DC=infoalias,DC=local
$DNs = @(
“DC=infoalias,dc=local”
)

# Create empty array
$AllADUsers = @()

# Loop through every DN
foreach ($DN in $DNs) {
$Users = Get-ADUser -SearchBase $DN -Filter * -Properties *

# Add users to array
$AllADUsers += $Users
}

# Create list
$AllADUsers | Sort-Object Name | Select-Object `
@{Label = “First name”; Expression = { $_.GivenName } },
@{Label = “Last name”; Expression = { $_.Surname } },
@{Label = “Display name”; Expression = { $_.DisplayName } },
@{Label = “User logon name”; Expression = { $_.SamAccountName } },
@{Label = “User principal name”; Expression = { $_.UserPrincipalName } },
@{Label = “Street”; Expression = { $_.StreetAddress } },
@{Label = “Description”; Expression = { $_.Description } },
@{Label = “E-mail”; Expression = { $_.Mail } },
@{Label = “HomePage”; Expression = { $_.wWWHomePage } },
@{Label = “Mobile”; Expression = { $_.mobile } },
@{Label = “Notes”; Expression = { $_.info } },
@{Label = “Distinguished Name”; Expression = { $_.distinguishedName } },
@{Label = “When Created”; Expression = { $_.whencreated } },
@{Label = “Last Password Set”; Expression = { $_.passwordlastset } },
@{Label = “Password Expiry”; Expression = { $_.UserPasswordExpiryTimeComputed } },
@{Label = “User Must change password Next logon”; Expression = { $_.ChangePasswordAtLogon } },

@{Label = “Password Never Expiry”; Expression = { $_.passwordNeverExpires } },

@{Label = “Account status”; Expression = { if (($_.Enabled -eq ‘TRUE’) ) { ‘Enabled’ } Else { ‘Disabled’ } } },
@{Label = “Last logon date”; Expression = { $_.lastlogondate } }|

# Export report to CSV file
Export-Csv -Encoding UTF8 -Path $Csvfile -NoTypeInformation #-Delimiter “;”




Get-ADUser -filter * -properties * | Select-Object GivenName, Surname, DisplayName, SamAccountName, UserPrincipalName, StreetAddress, Description, Mail, distinguishedName, whencreated, passwordlastset, UserPasswordExpiryTimeComputed, ChangePasswordAtLogon, passwordNeverExpires, Enabled, lastlogondate | Export-CSV -path C:\temp\GetUsers\AllADUsers.csv




