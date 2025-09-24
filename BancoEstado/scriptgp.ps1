###copiar para abajo ####

Import-Module ActiveDirectory

$BasePath = "C:\temp\Export-ADGroups"
if (-not (Test-Path $BasePath)) { New-Item -Path $BasePath -ItemType Directory | Out-Null }

# Función genérica para obtener letras A-Z + Otros
function Get-Alphabet {
    return @([char[]](65..90)) + "_Otros"
}

function GruposSinUsuarios {
    Write-Host "Buscando grupos sin usuarios (divididos por letra)..."
    foreach ($letra in Get-Alphabet) {
        $path = Join-Path $BasePath "$letra"
        if (-not (Test-Path $path)) { New-Item -Path $path -ItemType Directory | Out-Null }

        if ($letra -eq "_Otros") {
            $filtro = '-not(Name -like "[A-Z]*")'
        } else {
            $filtro = "Name -like '$letra*'"
        }

        $grupos = Get-ADGroup -Filter $filtro -Properties Members | Where-Object { $_.Members.Count -eq 0 }
        if ($grupos) {
            $file = Join-Path $path "Grupos_sin_usuarios.csv"
            $grupos | Select-Object Name, DistinguishedName | Export-Csv -Path $file -NoTypeInformation -Encoding UTF8 -Append
            Write-Host "Exportado: $file"
        }
    }
}

function GruposEnUso {
    $path = Join-Path $BasePath "GruposEnUso"
    if (-not (Test-Path $path)) { New-Item -Path $path -ItemType Directory | Out-Null }
    $file = Join-Path $path "GruposEnUso.csv"

    Write-Host "Identificando grupos en uso actualmente (divididos por letra)..."
    foreach ($letra in Get-Alphabet) {
        if ($letra -eq "_Otros") {
            $filtro = { -not (Name -like "[A-Z]*") }
        } else {
            $filtro = { Name -like "$letra*" }
        }

        $grupos = Get-ADGroup -Filter $filtro -Properties Members, MemberOf
        $gruposEnUso = $grupos | Where-Object { $_.Members.Count -gt 0 -or $_.MemberOf.Count -gt 0 }
        if ($gruposEnUso) {
            $gruposEnUso | Select-Object Name,@{Name="CantidadMiembros";Expression={$_.Members.Count}} | `
                Export-Csv -Path $file -NoTypeInformation -Encoding UTF8 -Append
        }
    }
    Write-Host "Archivo exportado en $file"
}

function GruposSinManager {
    Write-Host "Buscando grupos sin Manager (divididos por letra)..."
    foreach ($letra in Get-Alphabet) {
        $path = Join-Path $BasePath "$letra"
        if (-not (Test-Path $path)) { New-Item -Path $path -ItemType Directory | Out-Null }

        if ($letra -eq "_Otros") {
            $filtro = { -not (Name -like "[A-Z]*") }
        } else {
            $filtro = { Name -like "$letra*" }
        }

        $grupos = Get-ADGroup -Filter $filtro -Properties ManagedBy | Where-Object { -not $_.ManagedBy }
        if ($grupos) {
            $file = Join-Path $path "Grupos_sin_manager.csv"
            $grupos | Select-Object Name, DistinguishedName | Export-Csv -Path $file -NoTypeInformation -Encoding UTF8 -Append
            Write-Host "Exportado: $file"
        }
    }
}

function GruposConAnidados {
    Write-Host "Buscando grupos con anidados (divididos por letra)..."
    foreach ($letra in Get-Alphabet) {
        $path = Join-Path $BasePath "$letra"
        if (-not (Test-Path $path)) { New-Item -Path $path -ItemType Directory | Out-Null }

        if ($letra -eq "_Otros") {
            $filtro = { -not (Name -like "[A-Z]*") }
        } else {
            $filtro = { Name -like "$letra*" }
        }

        $grupos = Get-ADGroup -Filter $filtro -Properties Members
        foreach ($grupo in $grupos) {
            $nested = @()
            foreach ($m in $grupo.Members) {
                try {
                    $obj = Get-ADObject -Identity $m -Properties ObjectClass, DistinguishedName
                    if ($obj.ObjectClass -eq "group") {
                        $nested += [PSCustomObject]@{
                            GrupoPadre        = $grupo.Name
                            GrupoAnidado      = $obj.Name
                            DistinguishedName = $obj.DistinguishedName
                        }
                    }
                } catch {}
            }
            if ($nested.Count -gt 0) {
                $file = Join-Path $path "$($grupo.Name).csv"
                $nested | Export-Csv -Path $file -NoTypeInformation -Encoding UTF8
                Write-Host "Archivo creado: $file"
            }
        }
    }
}

function EliminarGruposSinUsuarios {
    Write-Host "Eliminando grupos sin usuarios (divididos por letra)..."
    foreach ($letra in Get-Alphabet) {
        if ($letra -eq "_Otros") {
            $filtro = { -not (Name -like "[A-Z]*") }
        } else {
            $filtro = { Name -like "$letra*" }
        }

        $grupos = Get-ADGroup -Filter $filtro -Properties Members | Where-Object { $_.Members.Count -eq 0 }
        foreach ($g in $grupos) {
            Write-Host "Eliminando grupo: $($g.Name)" -ForegroundColor Red
            Remove-ADGroup -Identity $g.DistinguishedName -Confirm:$false
        }
    }
    Write-Host "Proceso completado." -ForegroundColor Green
}

function MostrarMenu {
    Clear-Host
    Write-Host "====================================" -ForegroundColor Cyan
    Write-Host "   Script de Gestión de Grupos AD   " -ForegroundColor Cyan
    Write-Host "====================================" -ForegroundColor Cyan
    Write-Host "1. Identificar grupos sin usuarios (Exportar CSV)"
    Write-Host "2. Identificar grupos en uso (Exportar CSV)"
    Write-Host "3. Identificar grupos sin manager (Exportar CSV)"
    Write-Host "4. Identificar grupos con grupos anidados (Exportar CSV)"
    Write-Host "5. Eliminar grupos sin usuarios"
    Write-Host "6. Salir"
    Write-Host "===================================="
}

do {
    MostrarMenu
    $opcion = Read-Host "Seleccione una opción"
    switch ($opcion) {
        "1" { GruposSinUsuarios; Pause }
        "2" { GruposEnUso; Pause }
        "3" { GruposSinManager; Pause }
        "4" { GruposConAnidados; Pause }
        "5" { EliminarGruposSinUsuarios; Pause }
        "6" { Write-Host "Saliendo..."; break }
        Default { Write-Host "Opción inválida, intente nuevamente." -ForegroundColor Red; Pause }
    }
} while ($opcion -ne "6")

 