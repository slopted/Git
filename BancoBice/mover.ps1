Import-Module ActiveDirectory

$fecha = Get-Date
$pathLogs = "\\srvfs\F$\FS\Geradm2\Actualizaciondead\Log\historialcambios.txt"
Import-Csv \\srvfs\F$\FS\Geradm2\Actualizaciondead\Intranet.csv -Delimiter ';' -Encoding UTF7 | ForEach-Object {

#variabes csv
$displayname= $_."Apellido Usuario"+ " " +$_."Nombre Usuario"
$correo = $_."Correo"
$rut = ("" + $_."RUT"+ "-" +$_."Digito Rut").ToUpper()
$cargo = $_."Cargo"
$anexo = $_."Anexo"
$area = $_."Area"
$compañia = $_."Empresa"
$oficina = "" + $_."Ubicacion"+ "-"+ $_."Piso"+ "-" + $_."Sucursal"
$Rutjefatura = $_."Rut Jefatura"
$manager = Get-ADUser -Filter "employeeNumber -like '$Rutjefatura*'" | Select-Object DistinguishedName -ExpandProperty Distinguishedname


#atributos AD
$usuario           =Get-ADUser $_.Login -Properties DisplayName,mail,EmployeeNumber,title,ipPhone,department,company,streetAddress,manager
$ADDisplayname     =$usuario | Select-Object DisplayName -ExpandProperty Displayname
$ADMail            =$usuario | Select-Object mail -ExpandProperty mail
$ADEmployeeNumber  =$usuario | Select-Object EmployeeNumber -ExpandProperty EmployeeNumber
$ADTitle           =$usuario | Select-Object title -ExpandProperty title
$ADIpPhone         =$usuario | Select-Object ipPhone -ExpandProperty ipPhone
$ADDepartment      =$usuario | Select-Object department -ExpandProperty department
$ADCompany         =$usuario | Select-Object company -ExpandProperty company
$ADStreetAddress   =$usuario | Select-Object streetAddress -ExpandProperty streetAddress
$ADmanager         =$usuario | Select-Object manager -ExpandProperty manager


##seteos

    #Displayname
    if($displayname -ne $ADDisplayname){
    $usuariomodificado =""+$fecha +";"+$_.Login+";DisplayName;"+$ADDisplayname
    $usuariomodificado >> $pathLogs
    Get-ADUser $_.Login | set-aduser -DisplayName $displayname
    }
    #Mail
    if($correo -ne $ADMail){
    $usuariomodificado =""+$fecha +";"+$_.Login+";Mail;"+$ADMail
    $usuariomodificado >> $pathLogs
    Get-ADUser $_.Login | set-aduser -emailAddress $correo
    }
    #employeeNumber

    if($rut -ne $ADEmployeeNumber){
    $usuariomodificado =""+$fecha +";"+$_.Login+";EmployeeNumber;"+$ADEmployeeNumber
    $usuariomodificado >> $pathLogs
    Get-ADUser $_.Login | set-aduser -EmployeeNumber $rut
    }

    #title
    if($cargo -ne $ADTitle){
    $usuariomodificado =""+$fecha +";"+$_.Login+";title;"+$ADTitle
    $usuariomodificado >> $pathLogs
    Get-ADUser $_.Login | set-aduser -Title $cargo | set-aduser -Description $cargo
    }

    #ipPhone
    if($anexo -ne $ADIpPhone){
    $usuariomodificado =""+$fecha +";"+$_.Login+";ipPhone;"+$ADIpPhone
    $usuariomodificado >> $pathLogs
    Get-ADUser $_.Login | set-aduser -Replace @{ipPhone = $anexo}
    }

    #department
    if($area -ne $ADDepartment){
    $usuariomodificado =""+$fecha +";"+$_.Login+";department;"+$ADDepartment
    $usuariomodificado >> $pathLogs
    Get-ADUser $_.Login | set-aduser -Department $area
    }

    #company
    if($compañia -ne $ADCompany){
    $usuariomodificado =""+$fecha +";"+$_.Login+";company;"+$ADCompany
    $usuariomodificado >> $pathLogs
    Get-ADUser $_.Login | set-aduser -Company $compañia
    }

    #streetAddress
    if($oficina -ne $ADStreetAddress){
    $usuariomodificado =""+$fecha +";"+$_.Login+";streetAddress;"+$ADStreetAddress
    $usuariomodificado >> $pathLogs
    Get-ADUser $_.Login | set-aduser -StreetAddress $oficina
    }

    #Manager
    if($manager -ne $ADmanager){
    $usuariomodificado =""+$fecha +";"+$_.Login+";manager;"+$ADmanager
    $usuariomodificado >> $pathLogs
    Get-ADUser $_.Login | set-aduser -manager $manager
    }
}