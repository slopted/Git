<# OPTION1 - GPO Creation | Step by Step#

GPO Layout W11 - BIN
User Configuration -> Policies -> Windows Settings -> Scripts(Logon/Logoff)
    Logon -> Properties 
    Add
Load this Ps1 file where its download over the distribution path
#>
$startBinDir = “$env:LOCALAPPDATA\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState\”

if (Test-Path -Path $startBinDir) {

} else {
New-Item $startBinDir -itemType Directory
}

# Copy W11 Requirements
Copy-Item -Path “<File_source_bin_Location>” -Destination $startBinDir -Force

#Replace – Path “<File_source_bin_Location>” with the location of your start.bin file.