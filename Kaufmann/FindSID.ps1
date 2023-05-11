$SID = "S-1-5-21-855509983-2253770618-1866171751*"

Get-ADUser -Filter * -Properties * | where{$_.sidhistory -like $SID} | Select-Object Name, @{N='Enabled';E={$_.Enabled}}, @{N='SIDHistory';E={$_.SIDHistory}} | export-csv "C:\Temp\751.csv" -notypeinformation
Get-ADGroup -Filter * -Properties * | where{$_.sidhistory -like $SID} | Select-Object Name, @{N='Enabled';E={$_.Enabled}}, @{N='SIDHistory';E={$_.SIDHistory}} | export-csv "C:\Temp\751-2.csv" -notypeinformation




Get-ADUser -Filter * -Properties * | Select-Object Name, @{N='Enabled';E={$_.Enabled}}, @{N='SIDHistory';E={$_.SIDHistory}} | export-csv "C:\Temp\SIDHist.csv" -notypeinformation
