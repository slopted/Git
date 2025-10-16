Import-Module ActiveDirectory

Get-ADUser -SearchBase "OU=Test,OU=Usuarios,OU=Chile,OU=SDCHSA,DC=salmonesdechile,DC=corp" `
    -Filter * `
    -Properties sAMAccountName, Department |
    Select-Object sAMAccountName, Department