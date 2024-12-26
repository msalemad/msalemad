#########################################################################
#                    PERFIL PERSONAL DE POWERSHELL 7                    #
#        Archivo de configuración para personalizar la sesión           #
#        Usuario: Miguel                                                #
#        Fecha:   <26/12/2024>                                          #
#                                                                       #
#        Descripción:                                                   #
#        Este archivo contiene configuraciones, funciones y alias       #
#        personalizados para optimizar el uso de PowerShell.            #
#########################################################################

# ==================== 1. CONFIGURACIONES DE ENTORNO ====================
# Establecer el título de la ventana
$host.UI.RawUI.WindowTitle = "Miguel's Custom PowerShell"

# Establecer un prompt personalizado
function Prompt {
    "PS [$env:USERNAME@$env:COMPUTERNAME] > "
}

# ====================== 2. ALIAS PERSONALIZADOS ========================
# Alias para comandos de uso frecuente
Set-Alias ll Get-ChildItem
Set-Alias grep Select-String
Set-Alias vim notepad
Set-Alias la Get-ChildItem -Force
Set-Alias cls Clear-Host
Set-Alias new new-item
# ===================== 3. MODULOS PERSONALIZADOS =======================
# Importar módulos personalizados
# Import-Module -Name PoshGit
# ================== 4. FUNCIONES PERSONALIZADAS ========================
# Limpiar la pantalla y mostrar un mensaje de bienvenida
function Clear-And-Greet {
    Clear-Host
    Write-Host "¡Hola Miguel! Bienvenido a tu sesión personalizada de PowerShell!" -ForegroundColor Blue
}
Clear-And-Greet

# Listar procesos en un formato simplificado
function Get-ProcessList {
    Get-Process | Select-Object -Property Name, Id, CPU
}
# Hacer una copia de seguridad de un archivo
function Backup-File {
    param(
        [string]$FilePath
    )
    if (Test-Path $FilePath) {
        Copy-Item $FilePath "$FilePath.bak"
        Write-Host "Copia de seguridad creada para $FilePath"
    } else {
        Write-Host "Archivo no encontrado: $FilePath"
    }
}

# Mostrar el uso del disco
function Get-DiskUsage {
    Get-PSDrive -PSProvider FileSystem | Select-Object Name, @{Name="Used(GB)";Expression={[math]::round($_.Used/1GB,2)}}, @{Name="Free(GB)";Expression={[math]::round($_.Free/1GB,2)}}
}

# Actualizar módulos de PowerShell
function Update-Modules {
    Get-InstalledModule | ForEach-Object { Update-Module -Name $_.Name }
}

# Mostrar información del sistema
function Get-SystemInfo {
    Get-ComputerInfo | Select-Object CsName, WindowsVersion, OsArchitecture, CsProcessors, CsTotalPhysicalMemory
}

# Limpiar la caché de DNS
function Clear-DNSCache {
    Clear-DnsClientCache
    Write-Host "Caché de DNS limpiada."
}

# Reiniciar un servicio por nombre
function Restart-ServiceByName {
    param(
        [string]$ServiceName
    )
    Restart-Service -Name $ServiceName -Force
    Write-Host "Servicio $ServiceName reiniciado."
}

# Buscar una cadena en archivos
function Search-StringInFiles {
    param(
        [string]$Path,
        [string]$Pattern
    )
    Select-String -Path $Path -Pattern $Pattern
}

# Crear un nuevo directorio y navegar a él
function New-DirAndCD {
    param(
        [string]$DirName
    )
    New-Item -ItemType Directory -Path $DirName
    Set-Location -Path $DirName
}

# Crear un nuevo archivo y navegar a su ubicación
function New-FileAndCD {
    param(
        [string]$FileName
    )
    New-Item -ItemType File -Path $FileName
    Set-Location -Path (Split-Path -Path $FileName)
}
# =================== 5. VARIABLES DE ENTORNO ===========================
# Variables de entorno personalizadas
$env:MyCustomVar = "SomeValue"

# Agregar una ruta personalizada a la variable de entorno PATH
$env:Path += ";C:\MyCustomScripts"

# =================== 6. DIRECTORIO DE SCRIPTS ==========================
# Definir el directorio donde se almacenan los scripts para PowerShell
$scriptDirectory = "C:\Users\usuario\Documents\PowerShell\Scripts"
Set-Location -Path $scriptDirectory

# ===================== FIN DEL ARCHIVO DE PERFIL =======================