#$ADGroupList1 = (Get-ADGroup -Filter * -searchbase "OU=Servicios_de_Dominio,DC=teletica,DC=local" -Properties *).Name
#Get-ADGroup -filter * -properties * -searchbase "OU=Servicios_de_Dominio,DC=teletica,DC=local"| Select Name, distinguishedName | Export-Csv -Path C:\Temp\Groups\adGroupList.csv

New-ADOrganizationalUnit -Name "Servicios_de_Dominio" -Path "OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "System Center" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "SCOM" -Path "OU=System Center,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "SCCM" -Path "OU=System Center,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "MBAM" -Path "OU=System Center,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "SCVMM" -Path "OU=System Center,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "Grupos de Sistemas" -Path "OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "DLO" -Path "OU=Grupos de Sistemas,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "Grupos de acceso a redes" -Path "OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "VPN acceso remoto" -Path "OU=Grupos de acceso a redes,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "Services" -Path "OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "RODC" -Path "OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "ADMT" -Path "OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "IPAM" -Path "OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "Exchange" -Path "OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "Firmas Groups" -Path "OU=Exchange,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "Genesys Alcatel" -Path "OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "OTRS" -Path "OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "ERP" -Path "OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "PROD" -Path "OU=ERP,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "Grupos de Seguridad" -Path "OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "Isilon" -Path "OU=Grupos de Seguridad,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "Internet Access Groups" -Path "OU=Grupos de Seguridad,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "Cabletica" -Path "OU=Grupos de Seguridad,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "OU=Dynamics AX" -Path "OU=Grupos de Seguridad,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "Impresoras" -Path "OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "AVANTE" -Path "OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "Grupos de Distribucion de Correo" -Path "OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "RemoteApp" -Path "OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "SCOM" -Path "OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"

    New-ADOrganizationalUnit -Name "ADMT" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "AVANTE" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "CiscoISE" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "Dell VWorkspace" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "ERP" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "PROD" -Path "OU=ERP,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "TL" -Path "OU=ERP,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "Exchange" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "Firmas Groups" -Path "OU=Exchange,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "Genesys Alcatel" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "Grupos de acceso a redes" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "VPN acceso remoto" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "Grupos de Distribucion de Correo" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "Grupos de Seguridad" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "Cabletica" -Path "OU=Grupos de Seguridad,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "Dynamics AX" -Path "OU=Grupos de Seguridad,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "Internet Access Groups" -Path "OU=Grupos de Seguridad,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
            New-ADOrganizationalUnit -Name "Firepower 6.2" -Path "OU=Internet Access Groups,OU=Grupos de Seguridad,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
                New-ADOrganizationalUnit -Name "Cabletica" -Path "OU=Firepower 6.2,OU=Internet Access Groups,OU=Grupos de Seguridad,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
                    New-ADOrganizationalUnit -Name "Contac Center" -Path "OU=Cabletica,OU=Firepower 6.2,OU=Internet Access Groups,OU=Grupos de Seguridad,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
                    New-ADOrganizationalUnit -Name "General" -Path "OU=Cabletica,OU=Firepower 6.2,OU=Internet Access Groups,OU=Grupos de Seguridad,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
                    New-ADOrganizationalUnit -Name "Operaciones" -Path "OU=Cabletica,OU=Firepower 6.2,OU=Internet Access Groups,OU=Grupos de Seguridad,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
                    New-ADOrganizationalUnit -Name "Retenciones" -Path "OU=Cabletica,OU=Firepower 6.2,OU=Internet Access Groups,OU=Grupos de Seguridad,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
                    New-ADOrganizationalUnit -Name "Televentas" -Path "OU=Cabletica,OU=Firepower 6.2,OU=Internet Access Groups,OU=Grupos de Seguridad,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
                New-ADOrganizationalUnit -Name "Teletica" -Path "OU=Firepower 6.2,OU=Internet Access Groups,OU=Grupos de Seguridad,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
                    New-ADOrganizationalUnit -Name "General" -Path "OU=Teletica,OU=Firepower 6.2,OU=Internet Access Groups,OU=Grupos de Seguridad,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
                    New-ADOrganizationalUnit -Name "TI-Desarrollo" -Path "OU=Teletica,OU=Firepower 6.2,OU=Internet Access Groups,OU=Grupos de Seguridad,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
            New-ADOrganizationalUnit -Name "Internet CT Operaciones" -Path "OU=Internet Access Groups,OU=Grupos de Seguridad,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "Isilon" -Path "OU=Grupos de Seguridad,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "Grupos de Sistemas" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "DLO" -Path "OU=Grupos de Sistemas,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"

    New-ADOrganizationalUnit -Name "Impresoras" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "IPAM" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "Laserfiche" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "0365" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "OTRS" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "RemoteApp" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "RODC" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "SCOM" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "Services" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "SIE7ECR" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "SIEBEL CRM" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "SQL" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "System Center" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "MBAM" -Path "OU=System Center,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "SCCM" -Path "OU=System Center,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "SCOM" -Path "OU=System Center,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
        New-ADOrganizationalUnit -Name "SCVMM" -Path "OU=System Center,OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "VDI" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "Vertice" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"
    New-ADOrganizationalUnit -Name "VMWare" -Path "OU=Servicios_de_Dominio,OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL"

   
    Grupos de Sistemas
        DLO
    Impresoras
    IPAM
    Laserfiche
    0365
    OTRS
    RemoteApp
    RODC
    SCOM
    Services
        MSS
    SIE7ECR
    SIEBEL CRM
    SQL
    System Center
        MBAM
        SCCM
        SCOM
        SCVMM
    VDI
    Vertice
    VMWare
    










   
Import-Csv "C:\moverGrupos.csv" -Delimiter ';' -Encoding UTF7 | ForEach-Object {
    #variabes csv
    $adUsers= $_.""


    $displayname= $_."Nombre Usuario"+ " " + $_."Apellido Usuario"
    $correo = $_."Correo"
    $rut = "" + $_."RUT"+ "-" + $_."Digito Rut"
    $cargo = $_."Cargo"
    $anexo = $_."Anexo"
    $area = $_."Area"
    $compañia = $_."Empresa"
}

$adUsers = Import-Csv -Path "C:\Temp\AdusersList.csv"
$TargetOU = Import-Csv -Path "C:\Temp\AdusersList.csv"
$adUsers | ForEach-Object {
    # Get ad user
    $aduser = (Get-ADUser -Identity $_.SAMAccountName).distinguishedName
    Write-Host "Move ad user" $aduser
    # Move user to target OU
    Move-ADObject -Identity $aduser -TargetPath $TargetOU 
} 
 
    


CN=SCOM-Admins,OU=SCOM,OU=System Center,OU=Servicios_de_Dominio,DC=teletica,DC=local


OU=Grupos,OU=Costa_Rica,DC=LLACR,DC=LOCAL
