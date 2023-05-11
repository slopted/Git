New-Item –Path "HKCU:\dummy" –Name NetwrixKey
New-ItemProperty -Path "HKCU:\dummy\NetwrixKey" -Name "NetwrixParam" -Value ”NetwrixValue”  -PropertyType "String"

Remove-ItemProperty -Path "HKCU:\dummy\NetwrixKey" -Name "NetwrixParam"
Remove-Item -Path "HKCU:\dummy\NetwrixKey" -Recurse