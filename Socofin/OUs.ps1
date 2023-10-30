Import-Module GroupPolicy
Import-Module ServerManager


#Tier 0
New-ADOrganizationalUnit -Name "Tier 0" -Path "OU=Admin,DC=socofin,DC=cl"
New-ADOrganizationalUnit -Name "Accounts" -Path "OU=Tier 0,OU=Admin,DC=socofin,DC=cl"
New-ADOrganizationalUnit -Name "Devices" -Path "OU=Tier 0,OU=Admin,DC=socofin,DC=cl"
New-ADOrganizationalUnit -Name "Groups" -Path "OU=Tier 0,OU=Admin,DC=socofin,DC=cl"
New-ADOrganizationalUnit -Name "Service Accounts" -Path "OU=Tier 0,OU=Admin,DC=socofin,DC=cl"
New-ADOrganizationalUnit -Name "Tier 0 Servers" -Path "OU=Tier 0,OU=Admin,DC=socofin,DC=cl"
#Tier 1
New-ADOrganizationalUnit -Name "Tier 1" -Path "OU=Admin,DC=socofin,DC=cl"
New-ADOrganizationalUnit -Name "Accounts" -Path "OU=Tier 1,OU=Admin,DC=socofin,DC=cl"
New-ADOrganizationalUnit -Name "Devices" -Path "OU=Tier 1,OU=Admin,DC=socofin,DC=cl"
New-ADOrganizationalUnit -Name "Groups" -Path "OU=Tier 1,OU=Admin,DC=socofin,DC=cl"
New-ADOrganizationalUnit -Name "Service Accounts" -Path "OU=Tier 1,OU=Admin,DC=socofin,DC=cl"
New-ADOrganizationalUnit -Name "Tier 1 Servers" -Path "OU=Tier 1,OU=Admin,DC=socofin,DC=cl"
#Tier 2
New-ADOrganizationalUnit -Name "Tier 2" -Path "OU=Admin,DC=socofin,DC=cl"
New-ADOrganizationalUnit -Name "Accounts" -Path "OU=Tier 2,OU=Admin,DC=socofin,DC=cl"
New-ADOrganizationalUnit -Name "Devices" -Path "OU=Tier 2,OU=Admin,DC=socofin,DC=cl"
New-ADOrganizationalUnit -Name "Groups" -Path "OU=Tier 2,OU=Admin,DC=socofin,DC=cl"
New-ADOrganizationalUnit -Name "Service Accounts" -Path "OU=Tier 2,OU=Admin,DC=socofin,DC=cl"
New-ADOrganizationalUnit -Name "Workstations" -Path "OU=Tier 2,OU=Admin,DC=socofin,DC=cl"
New-ADOrganizationalUnit -Name "Desktops" -Path "OU=Workstations,OU=Tier 2,OU=Admin,DC=socofin,DC=cl"
New-ADOrganizationalUnit -Name "Kiosks" -Path "OU=Workstations,OU=Tier 2,OU=Admin,DC=socofin,DC=cl"
New-ADOrganizationalUnit -Name "Laptops" -Path "OU=Workstations,OU=Tier 2,OU=Admin,DC=socofin,DC=cl"
New-ADOrganizationalUnit -Name "Staging" -Path "OU=Workstations,OU=Tier 2,OU=Admin,DC=socofin,DC=cl"


#Bloqueo de herencia de GPO en PAWs
Set-GpInheritance -target "OU=Devices,OU=Tier 0,OU=Admin,DC=socofin,DC=cl" -IsBlocked Yes | Out-Null
Set-GpInheritance -target "OU=Devices,OU=Tier 1,OU=Admin,DC=socofin,DC=cl" -IsBlocked Yes | Out-Null
Set-GpInheritance -target "OU=Devices,OU=Tier 2,OU=Admin,DC=socofin,DC=cl" -IsBlocked Yes | Out-Null
