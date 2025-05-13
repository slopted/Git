# List of paths
$paths = @(
    "\\UNAV-BDPRD-WEB2.Ultranav.cl\C$\Temp",
    "\\UNAV-BDQA-WEB2.Ultranav.cl\C$\Temp",
    "\\UNAV-PIVOTDMZ.Ultranav.cl\C$\Temp",
    "\\unav-prd-apps2606.Ultranav.cl\C$\Temp",
    "\\UNAV-PRD-BD.Ultranav.cl\C$\Temp",
    "\\UNAV-QAS-DB.Ultranav.cl\C$\Temp",
    "\\UNAV-PRINT.Ultranav.cl\C$\Temp",
    "\\UNAV-QLIK-DEV.Ultranav.cl\C$\Temp",
    "\\UNAV-QPUB-PRDN.Ultranav.cl\C$\Temp",
    "\\UNAV-QASN.Ultranav.cl\C$\Temp",
    "\\UNAV-QSVR-PRDN.Ultranav.cl\C$\Temp",
    "\\UNAV-RPA-PRD01.Ultranav.cl\C$\Temp",
    "\\UNAV-RPA-PRD02.Ultranav.cl\C$\Temp",
    "\\UNAV-UTMSAPP2.Ultranav.cl\C$\Temp",
    "\\UNAV-TEN01.Ultranav.cl\C$\Temp",
    "\\UNAV-UTMSBD2.Ultranav.cl\C$\Temp",
    "\\UNAV-IISQA-WEB2\C$\Temp",
    "\\UNAV-PRDW-DMZ\C$\Temp",
    "\\UNAV-PRD-WEB2N\C$\Temp",
    "\\UNAV-IISQA-WEB3N\C$\Temp"
)

# Open each path in File Explorer
foreach ($path in $paths) {
    Start-Process explorer.exe $path
}