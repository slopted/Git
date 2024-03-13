$csv = import-csv "C:\Users\Nicolas\OneDrive - XMS - v2\OneDrive - XMS TECHNOLOGIES S.A\Documentos 2022\Provida\Movimiento FS\Fileservers\mlclfs05\DependencyGroup.csv"
$outfile = 'C:\Users\Nicolas\OneDrive - XMS - v2\OneDrive - XMS TECHNOLOGIES S.A\Documentos 2022\Provida\Movimiento FS\Fileservers\mlclfs05\yuml.txt'
foreach ($item in $csv) {
'['+$item.Destination+']-'+$item.Localport+'>['+$item.Source+']' | Out-File -Encoding ascii -FilePath $outfile -Append
}