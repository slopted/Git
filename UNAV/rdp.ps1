param (
    [string[]]$Hostnames = @(
        "unav-prd-apps2606.Ultranav.cl",
        "UNAV-PRD-BD.Ultranav.cl",
        "UNAV-QAS-DB.Ultranav.cl",
        "UNAV-PRINT.Ultranav.cl",
        "UNAV-QLIK-DEV.Ultranav.cl",
        "UNAV-QPUB-PRDN.Ultranav.cl",
        "UNAV-QASN.Ultranav.cl",
        "UNAV-QSVR-PRDN.Ultranav.cl",
        "UNAV-RPA-PRD01.Ultranav.cl",
        "UNAV-RPA-PRD02.Ultranav.cl",
        "UNAV-UTMSAPP2.Ultranav.cl",
        "UNAV-TEN01.Ultranav.cl",
        "UNAV-UTMSBD2.Ultranav.cl",
        "UNAV-IISQA-WEB2",
        "UNAV-PRDW-DMZ",
        "UNAV-PRD-WEB2N",
        "UNAV-IISQA-WEB3N"
    ),
    [string]$Username = "xms.t1"
    #Add the password [string]$Password
)

# Create a temporary credentials file
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force

foreach ($Hostname in $Hostnames) {
    $RdpFilePath = "$env:TEMP\$($Hostname -replace '\.', '_').rdp"

    # Generate RDP file content
    $RdpContent = @"
full address:s:$Hostname
username:s:$Username
password 51:b:$($SecurePassword | ConvertFrom-SecureString)
"@

    # Write the RDP file
    Set-Content -Path $RdpFilePath -Value $RdpContent

    # Launch Remote Desktop Connection
    Start-Process "mstsc.exe" -ArgumentList $RdpFilePath
}