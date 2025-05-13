# Define the list of remote servers
$remoteServers = @(
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
    "UNAV-TEN01.Ultranav.cl",
    "UNAV-UTMSBD2.Ultranav.cl"
)

# Define the command to execute
$command = 'C:\temp\Microsoft-ASR_UA_9.63.0.0_Windows_GA_21Oct2024_Release.exe /Role "MS" /InstallLocation "C:\Program Files (x86)\Microsoft Azure Site Recovery" /Platform "VmWare" /Silent /CSType CSLegacy'

# Loop through each server and execute the command
foreach ($remoteServer in $remoteServers) {
    Write-Output "Executing command on $remoteServer..."
    $result = Invoke-Command -ComputerName $remoteServer -ScriptBlock {
        param ($cmd)
        try {
            & $cmd
            if ($LASTEXITCODE -eq 0) {
                Write-Output "Command executed successfully on $env:COMPUTERNAME."
            } else {
                Write-Output "Command failed with exit code $LASTEXITCODE on $env:COMPUTERNAME."
            }
        } catch {
            Write-Output "An error occurred on $env:COMPUTERNAME: $_"
        }
    } -ArgumentList $command

    # Output the result
    Write-Output $result
}



cd C:\temp
.\Microsoft-ASR_UA_9.63.0.0_Windows_GA_21Oct2024_Release.exe /Role "MS" /InstallLocation "C:\Program Files (x86)\Microsoft Azure Site Recovery" /Platform "VmWare" /Silent  /CSType CSLegacy
cd "C:\Program Files (x86)\Microsoft Azure Site Recovery\agent"
.\UnifiedAgentConfigurator.exe  /CSEndPoint 10.10.89.55 /PassphraseFilePath C:\temp\pass.txt

