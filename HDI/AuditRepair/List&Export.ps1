$varPath = "C:\GPOExport\"

$arrGPOList = Get-GPO -All

foreach ($varPolicy in $arrGPOList) {

                $tmpPath = $varPath + $varPolicy.DisplayName + ".html"

                $varPolicy.DisplayName

                Get-GPOReport -Name $varPolicy.DisplayName -ReportType HTML -Path $tmpPath}