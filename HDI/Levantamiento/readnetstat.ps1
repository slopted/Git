
$null, $null, $null, $null, $netstat = Get-Content -Path "C:\Users\Nicolas\OneDrive - XMS - v2\OneDrive - XMS TECHNOLOGIES S.A\Documentos 2022\Provida\Movimiento FS\Fileservers\mlclfs05\tcpconn2.txt"
[regex]$regexTCP = '(?<Protocol>\S+)\s+((?<LAddress>(2[0-4]\d|25[0-5]|[01]?\d\d?)\.(2[0-4]\d|25[0-5]|[01]?\d\d?)\.(2[0-4]\d|25[0-5]|[01]?\d\d?)\.(2[0-4]\d|25[0-5]|[01]?\d\d?))|(?<LAddress>\[?[0-9a-fA-f]{0,4}(\:([0-9a-fA-f]{0,4})){1,7}\%?\d?\]))\:(?<Lport>\d+)\s+((?<Raddress>(2[0-4]\d|25[0-5]|[01]?\d\d?)\.(2[0-4]\d|25[0-5]|[01]?\d\d?)\.(2[0-4]\d|25[0-5]|[01]?\d\d?)\.(2[0-4]\d|25[0-5]|[01]?\d\d?))|(?<RAddress>\[?[0-9a-fA-f]{0,4}(\:([0-9a-fA-f]{0,4})){1,7}\%?\d?\]))\:(?<RPort>\d+)\s+(?<State>\w+)\s+(?<PID>\d+$)'
[regex]$regexUDP = '(?<Protocol>\S+)\s+((?<LAddress>(2[0-4]\d|25[0-5]|[01]?\d\d?)\.(2[0-4]\d|25[0-5]|[01]?\d\d?)\.(2[0-4]\d|25[0-5]|[01]?\d\d?)\.(2[0-4]\d|25[0-5]|[01]?\d\d?))|(?<LAddress>\[?[0-9a-fA-f]{0,4}(\:([0-9a-fA-f]{0,4})){1,7}\%?\d?\]))\:(?<Lport>\d+)\s+(?<RAddress>\*)\:(?<RPort>\*)\s+(?<PID>\d+)'
[psobject]$process = "" | Select-Object Protocol, LocalAddress, Localport, RemoteAddress, Remoteport, State, PID
#$Services = @{}

foreach ($net in $netstat)
{
    switch -regex ($net.Trim())
    {
        $regexTCP
        {          
            $process.Protocol = $matches.Protocol
            $process.LocalAddress = $matches.LAddress
            $process.Localport = $matches.LPort
            $process.RemoteAddress = $matches.RAddress
            $process.Remoteport = $matches.RPort
            $process.State = $matches.State
            $process.PID = $matches.PID
            #$process.ProcessName = "nodata" #@((Get-Process -ComputerName $servername -Id $matches.PID -ea 0).ProcessName)
            #$process.Services = $Services.Item($matches.PID)
        }
        $regexUDP
        {          
        $process.Protocol = $matches.Protocol
            $process.LocalAddress = $matches.LAddress
            $process.Localport = $matches.LPort
            $process.RemoteAddress = $matches.RAddress
            $process.Remoteport = $matches.RPort
            $process.State = $matches.State
            $process.PID = $matches.PID
            #$process.ProcessName = "nodata2" #@((Get-Process -ComputerName $servername -Id $matches.PID -ea 0).ProcessName)
            #$process.Services = $Services.Item($matches.PID)
            }
    }
$process | where {$_.state -eq "ESTABLISHED" -and ($_.remoteaddress -like "172.*" -or $_.remoteaddress -like "30.*" -or $_.remoteaddress -like "10.*") -and $_.LocalPort -notmatch "445"}| Select @{n='Source';e={$_.LocalAddress}},Localport,@{n='Destination';e={$_.RemoteAddress}}| export-csv -NoTypeInformation "C:\Users\Nicolas\OneDrive - XMS - v2\OneDrive - XMS TECHNOLOGIES S.A\Documentos 2022\Provida\Movimiento FS\Fileservers\mlclfs05\DependencyGroup.csv" -Append
}

