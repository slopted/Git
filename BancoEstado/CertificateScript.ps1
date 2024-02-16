$forest = "banco.bestado.cl"   
$file = "C:\temp\certs.csv"
$content = "C:\temp\error.csv"   
$cred = Get-Credential ""   
$out=(Get-ADForest -Identity  $forest).Domains | 
ForEach-Object 
            {       (Get-ADcomputer -Filter * -SearchBase "OU=IT, DC=contoso, DC=com" -server $_).DNSHostName | ForEach-Object 
                {           Invoke-Command -ComputerName $_ -credential $cred -HideComputerName -ScriptBlock 
                    {                Get-ChildItem -Path Cert:\LocalMachine -Recurse | Where-Object {$_.PSISContainer -eq $false} |
                                     Select-Object -Property Thumbprint,Subject,Issuer,NotBefore,NotAfter
                    }
                }
            } |
Select-Object -Property * -ExcludeProperty RunSpaceID,PSShowComputerName |
Test-Path -Path "C:\temp\" |
Export-Csv -Path $file -NoTypeInformation


#Get-ADComputer -Filter * -SearchBase "OU=IT, DC=contoso, DC=com"
#set-content C:\EDI\FTPScripts\Errors\Export.log $error

<# Version compartida
$forest = "<DOMAIN>"
$file = "C:\temp\certs.csv"
$cred = Get-Credential ""
$out=(Get-ADForest -Identity $forest).Domains |
      ForEach-Object {      
                    (Get-ADcomputer -Filter * -SearchBase "<OU Location ex.(OU=Domain Controllers,DC=bestado,DC=cl)>" -server $_).DNSHostName | 
                    ForEach-Object {
                                Invoke-Command -ComputerName $_ -credential $cred -HideComputerName -ScriptBlock{
                                                                                                                Get-ChildItem -Path Cert:\LocalMachine -Recurse |
                                                                                                                Where-Object {$_.PSISContainer -eq $false} |
                                                                                                                Select-Object -Property Thumbprint,Subject,Issuer,NotBefore,NotAfter
                                                                                                                }
                                    }
                    } | Select-Object -Property * -ExcludeProperty RunSpaceID,PSShowComputerName | Export-Csv -Path $file -NoTypeInformation 
                    #>