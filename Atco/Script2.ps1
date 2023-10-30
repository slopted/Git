#CSS codes
$header = @"
<style>

    h1 {
        text-align: center;
        font-family: Arial, Helvetica, sans-serif;
        color: #e68a00;
        font-size: 28px;
    }

    h2 {
        font-family: Arial, Helvetica, sans-serif;
        color: #000099;
        font-size: 16px;
    }
    
   table {
		font-size: 12px;
		border: 0px; 
		font-family: Arial, Helvetica, sans-serif;
	} 
	
    td {
		padding: 4px;
		margin: 0px;
		border: 0;
	}
	
    th {
        background: #395870;
        background: linear-gradient(#49708f, #293f50);
        color: #fff;
        font-size: 11px;
        text-transform: uppercase;
        padding: 10px 15px;
        vertical-align: middle;
	}

    tbody tr:nth-child(even) {
        background: #f0f0f2;
    }
    
    #CreationDate {

        font-family: Arial, Helvetica, sans-serif;
        color: #ff3300;
        font-size: 12px;

    }

    .StopStatus {

        color: #ff0000;
    }
     
    .RunningStatus {

        color: #008000;
    }
    .TittleStatus {

        color: #ff0000;
        font-size: 12px;
    }

</style>
"@


#The command below will get the domain to get the report
$Domain = (Get-ADDomain).Forest
#Add Logo
$att1 = new-object Net.Mail.Attachment ("C:\Temp\src\Logo.png")
$att1.ContentId = "logo.png"
$Image = "<img src='cid:logo.png' height='75px' width='133px' alt='site’s logo' align='right'>"
#Tittle
$DomainTag = "<h1>Domain: $Domain</h1>"


$Administrators = Get-ADGroupMember -Identity "Administrators"
$BackupOperators = Get-ADGroupMember -Identity "Backup Operators"
$DnsAdmins = Get-ADGroupMember -Identity "DnsAdmins"
$DomainAdmins = Get-ADGroupMember -Identity "Domain Admins" 
$EnterpriseAdmins = Get-ADGroupMember -Identity "Enterprise Admins" 
$EnterpriseKeyAdmins = Get-ADGroupMember -Identity "Enterprise Key Admins" 
$SchemaAdmins = Get-ADGroupMember -Identity "Schema Admins" 
$ServerOperators = Get-ADGroupMember -Identity "Server Operators"
$GroupPolicyCreatorOwners = Get-ADGroupMember -Identity "Group Policy Creator Owners" 


if ([string]::IsNullOrWhiteSpace($Administrators)) {
    $Administrators = $Administrators | ConvertTo-Html -Fragment -PreContent "<h2>Administrators</h2><h2 class='TittleStatus'>The group is empty</h2>"
} else {
    $Administrators = Get-ADGroupMember -Identity "Administrators" | ConvertTo-Html -Property Name,ObjectClass,DistinguishedName -Fragment -PreContent "<h2>Administrators</h2>"
}

if ([string]::IsNullOrWhiteSpace($BackupOperators)) {
    $BackupOperators = $BackupOperators | ConvertTo-Html -Fragment -PreContent "<h2>Backup Operators</h2><h2 class='TittleStatus'>The group is empty</h2>"
} else {
    $BackupOperators = Get-ADGroupMember -Identity "Backup Operators" | ConvertTo-Html -Property Name,ObjectClass,DistinguishedName -Fragment -PreContent "<h2>Backup Operators</h2>"
}

if ([string]::IsNullOrWhiteSpace($DnsAdmins)) {
    $DnsAdmins = $DnsAdmins | ConvertTo-Html -Fragment -PreContent "<h2>DnsAdmins</h2><h2 class='TittleStatus'>The group is empty</h2>"
} else {
    $DnsAdmins = Get-ADGroupMember -Identity "DnsAdmins" | ConvertTo-Html -Property Name,ObjectClass,DistinguishedName -Fragment -PreContent "<h2>DnsAdmins</h2>"
}

#$DHCPAdministrators = Get-ADGroupMember -Identity "DHCPAdministrators" | ConvertTo-Html -Property Name,ObjectClass,DistinguishedName -Fragment -PreContent "<h2>DHCP Administrators</h2>"
if ([string]::IsNullOrWhiteSpace($DomainAdmins)) {
    $DomainAdmins = $DomainAdmins | ConvertTo-Html -Fragment -PreContent "<h2>Domain Admins</h2><h2 class='TittleStatus'>The group is empty</h2>"
} else {
    $DomainAdmins = Get-ADGroupMember -Identity "Domain Admins" | ConvertTo-Html -Property Name,ObjectClass,DistinguishedName -Fragment -PreContent "<h2>Domain Admins</h2>"
}

if ([string]::IsNullOrWhiteSpace($EnterpriseAdmins)) {
    $EnterpriseAdmins = $EnterpriseAdmins | ConvertTo-Html -Fragment -PreContent "<h2>Enterprise Admins</h2><h2 class='TittleStatus'>The group is empty</h2>"
} else {
    $EnterpriseAdmins = Get-ADGroupMember -Identity "Enterprise Admins" | ConvertTo-Html -Property Name,ObjectClass,DistinguishedName -Fragment -PreContent "<h2>Enterprise Admins</h2>"
}

if ([string]::IsNullOrWhiteSpace($EnterpriseKeyAdmins)) {
    $EnterpriseKeyAdmins = $DnEnterpriseKeyAdminssAdmins | ConvertTo-Html -Fragment -PreContent "<h2>Enterprise Key Admins</h2><h2 class='TittleStatus'>The group is empty</h2>"
} else {
    $EnterpriseKeyAdmins = Get-ADGroupMember -Identity "Enterprise Key Admins" | ConvertTo-Html -Property Name,ObjectClass,DistinguishedName -Fragment -PreContent "<h2>Enterprise Key Admins</h2>"
}

if ([string]::IsNullOrWhiteSpace($SchemaAdmins)) {
    $SchemaAdmins = $SchemaAdmins | ConvertTo-Html -Fragment -PreContent "<h2>Schema Admins</h2><h2 class='TittleStatus'>The group is empty</h2>"
} else {
    $SchemaAdmins = Get-ADGroupMember -Identity "Schema Admins" | ConvertTo-Html -Property Name,ObjectClass,DistinguishedName -Fragment -PreContent "<h2>Schema Admins</h2>"
}

if ([string]::IsNullOrWhiteSpace($ServerOperators)) {
    $ServerOperators = $ServerOperators | ConvertTo-Html -Fragment -PreContent "<h2>Server Operators</h2><h2 class='TittleStatus'>The group is empty</h2>"
} else {
    $ServerOperators = Get-ADGroupMember -Identity "Server Operators" | ConvertTo-Html -Property Name,ObjectClass,DistinguishedName -Fragment -PreContent "<h2>Server Operators</h2>"
}

if ([string]::IsNullOrWhiteSpace($GroupPolicyCreatorOwners)) {
    $GroupPolicyCreatorOwners = $GroupPolicyCreatorOwners | ConvertTo-Html -Fragment -PreContent "<h2>Group Policy Creator Owners</h2><h2 class='TittleStatus'>The group is empty</h2>"
} else {
    $GroupPolicyCreatorOwners = Get-ADGroupMember -Identity "Group Policy Creator Owners" | ConvertTo-Html -Property Name,ObjectClass,DistinguishedName -Fragment -PreContent "<h2>Group Policy Creator Owners</h2>"
}


$recently = [DateTime]::Today.AddDays(-60)
#$AddedDomainComputers = Get-ADComputer -Filter 'WhenCreated -ge $recently'| ConvertTo-Html -Properties Name,whenCreated,DistinguishedName -Fragment -PreContent "<h2>Last Computers Joinned to Domain - 60 days</h2>"  
#$AddedDomainComputers = Get-ADComputer -Filter 'WhenCreated -ge $recently' -Properties whenCreated  | ConvertTo-Html -As List -Fragment -PreContent "<h2>Last Computers Joinned to Domain - 60 days</h2>" 
$AddedDomainComputers = Get-ADComputer -Filter 'WhenCreated -ge $recently' -Properties whenCreated  | ConvertTo-Html -Property Name,whenCreated,distinguishedName -Fragment -PreContent "<h2>Last Computers Joinned to Domain - 60 days</h2>" 
# Select-Object -First 20  |ConvertTo-Html -Property Name,whenCreated,distinguishedName


#The command below will get the Operating System information, convert the result to HTML code as table and store it to a variable
$OSinfo = Get-CimInstance -Class Win32_OperatingSystem | ConvertTo-Html -As List -Property Version,Caption,BuildNumber,Manufacturer -Fragment -PreContent "<h2>Operating System Information</h2>"

#The command below will get the Processor information, convert the result to HTML code as table and store it to a variable
$ProcessInfo = Get-CimInstance -ClassName Win32_Processor | ConvertTo-Html -As List -Property DeviceID,Name,Caption,MaxClockSpeed,SocketDesignation,Manufacturer -Fragment -PreContent "<h2>Processor Information</h2>"

#The command below will get the BIOS information, convert the result to HTML code as table and store it to a variable
$BiosInfo = Get-CimInstance -ClassName Win32_BIOS | ConvertTo-Html -As List -Property SMBIOSBIOSVersion,Manufacturer,Name,SerialNumber -Fragment -PreContent "<h2>BIOS Information</h2>"

#The command below will get the details of Disk, convert the result to HTML code as table and store it to a variable
$DiscInfo = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" | ConvertTo-Html -As List -Property DeviceID,DriveType,ProviderName,VolumeName,Size,FreeSpace -Fragment -PreContent "<h2>Disk Information</h2>"

#The command below will get first 10 services information, convert the result to HTML code as table and store it to a variable
$ServicesInfo = Get-CimInstance -ClassName Win32_Service | Select-Object -First 20  |ConvertTo-Html -Property Name,DisplayName,State -Fragment -PreContent "<h2>Services Information</h2>"
$ServicesInfo = $ServicesInfo -replace '<td>Running</td>','<td class="RunningStatus">Running</td>'
$ServicesInfo = $ServicesInfo -replace '<td>Stopped</td>','<td class="StopStatus">Stopped</td>'

  
#The command below will combine all the information gathered into a single HTML report
$Report = ConvertTo-HTML -Body "$Image $DomainTag $Administrators $BackupOperators $DnsAdmins $DomainAdmins $EnterpriseAdmins $EnterpriseKeyAdmins $SchemaAdmins $ServerOperators $GroupPolicyCreatorOwners $AddedDomainComputers $OSinfo $ProcessInfo $BiosInfo $DiscInfo $ServicesInfo" -Head $header -Title "Computer Information Report" -PostContent "<p id='CreationDate'>Creation Date: $(Get-Date)</p>"



#The command below will generate the report to an HTML file
$Report | Out-File C:\Temp\ReportAudit-PrivilageGroups.html
$Body = Get-Content C:\Temp\ReportAudit-PrivilageGroups.html

#Get Date
$ReportDate = Get-Date -format "MM-dd-yyyy"
 
#Configuration Variables for E-mail
$SmtpServer = "smtp-relay.sendinblue.com" #or IP Address such as "10.125.150.250"
$EmailFrom = "informatica@atcosabinco.com"
$EmailTo = "asanchez@xmslatam.com"
$EmailSubject = "Report Audit Privilage Users - Daily Report on: "+$ReportDate
$Attacnments = "C:\Temp\src\Logo.png"

 

#$secpasswd = ConvertTo-SecureString "3K5hMD1VFxfjtN6L" -AsPlainText -Force
$secpasswd = ConvertTo-SecureString "3K5hMD1VFxfjtN6L" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ("dtesabinco@atcosabinco.com", $secpasswd)
#$cred = New-Object System.Management.Automation.PSCredential ("dtesabinco@atcosabinco.com", "3K5hMD1VFxfjtN6L")#$secpasswd)
Send-MailMessage -SmtpServer $SmtpServer -From $EmailFrom -To $EmailTo -Subject $EmailSubject  -Port 587 -Credential $cred -UseSsl -Body "$Body" -BodyAsHtml -Attachments $Attacnments


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