<# OPTION1 - GPO Creation Register Item | Step by Step#

GPO Layout W11 - LEFT ALIGNMENT
User Configuration -> Preferences -> Windows Settings -> Registry
    NEW -> Registry Item

        Create a new Registry Item in GPO settings (User Configuration)
            Path      : HKEY_CURRENT_USER
            Action    : Update 
            KeyPath   : Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
            ValueName : TaskbarAl
            ValueType : REG_DWORD
            ValueData : 0
            Base      : <Any>


<# OPTION2 - GPO Creation bash execution | Step by Step#

GPO Layout W11 - LEFT ALIGNMENT
User Configuration -> Policies -> Windows Settings -> Scripts(Logon/Logoff)
    Logon -> Properties 
    Add
Load this Ps1 file where its download over the distribution path
#>
#Value Variable
$taskbarAl = 0000000
#Registry Path Variable
$regpath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
#Command
New-ItemProperty -Path "$regpath" -Name "TaskbarAl" -Value "$taskbarAl"  -PropertyType "DWORD" -Force