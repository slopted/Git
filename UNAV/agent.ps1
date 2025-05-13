# Define the source file and destination folder
$sourceFile = "E:\Program Files (x86)\Microsoft Azure Site Recovery\home\svsystems\pushinstallsvc\repository\Microsoft-ASR_UA_9.63.0.0_Windows_GA_21Oct2024_Release"
$destinationFolder = "C:\Temp\"

# List of servers
$servers = @(
    "UNAV-BDPRD-WEB2.Ultranav.cl",
    "UNAV-BDQA-WEB2.Ultranav.cl",
    "UNAV-PIVOTDMZ.Ultranav.cl",
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
)

# Loop through each server and copy the file
foreach ($server in $servers) {
    $destinationPath = "\\$server\$($destinationFolder.TrimStart('C:\'))"
    Write-Host "Copying file to $server..."

    try {
        # Ensure the destination folder exists
        Invoke-Command -ComputerName $server -ScriptBlock {
            param($destinationFolder)
            if (-not (Test-Path -Path $destinationFolder)) {
                New-Item -ItemType Directory -Path $destinationFolder -Force
            }
        } -ArgumentList $destinationFolder

        # Copy the file
        Copy-Item -Path $sourceFile -Destination $destinationPath -Force
        Write-Host "File copied successfully to $server"
        Add-Content -Path "C:\Temp\copy_log.txt" -Value "[$(Get-Date)] Success: File copied to $server"
    } catch {
        $errorMessage = "[$(Get-Date)] Error: Failed to copy file to $server. Reason: $_"
        Write-Host $errorMessage -ForegroundColor Red
        Add-Content -Path "C:\Temp\copy_log.txt" -Value $errorMessage
    }
}






C:\temp\Microsoft-ASR_UA_9.63.0.0_Windows_GA_21Oct2024_Release.exe