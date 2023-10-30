
#$secpasswd = ConvertTo-SecureString "3K5hMD1VFxfjtN6L" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ("dtesabinco@atcosabinco.com", "3K5hMD1VFxfjtN6L")#$secpasswd)
Send-MailMessage -From 'informatica@atcosabinco.com' -To 'asanchez@xmslatam.com' -Subject 'Report Audit - Privilage Users' -SmtpServer smtp-relay.sendinblue.com -Port 587 -Credential $cred -UseSsl -Body "Test"




#Send-MailMessage -From 'User01 <user01@fabrikam.com>' -To 'User02 <user02@fabrikam.com>' -Subject 'Test mail'
 <#>   
    [-Attachments <String[]>]
    [-Bcc <String[]>]
    [[-Body] <String>]
    [-BodyAsHtml]
    [-Encoding <Encoding>]
    [-Cc <String[]>]
    [-DeliveryNotificationOption <DeliveryNotificationOptions>]
    -From <String>
    [[-SmtpServer] <String>]
    [-Priority <MailPriority>]
    [-ReplyTo <String[]>]
    [[-Subject] <String>]
    [-To] <String[]>
    [-Credential <PSCredential>]
    [-UseSsl]
    [-Port <Int32>]
    [<CommonParameters>]
    #>