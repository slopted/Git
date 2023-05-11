$path1 = 'HKLM:\Software\Microsoft\Cryptography\Protect\Providers\df9d8cd0-1501-11d1-8c7a-00c04fc297eb'  
Remove-ItemProperty -Path $path1 -Name 'df9d8cd0-1501-11d1-8c7a-00c04fc297eb'
New-ItemProperty -Path $path1 -Name 'df9d8cd0-1501-11d1-8c7a-00c04fc297eb' -Value 1 -PropertyType DWord