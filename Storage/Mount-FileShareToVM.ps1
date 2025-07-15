<#
.SYNOPSIS
    Mounts an Azure file share to a Windows VM using PowerShell.

.DESCRIPTION
    Mounts an Azure file share to a Windows VM using PowerShell.
    Script reads parameters from CSV and uses Azure PowerShell modules.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Mount-FileShareToVM.csv"
foreach ($p in $params) {
    $netPath = "\\$($p.StorageAccountName).file.core.windows.net\$($p.FileShareName)"
    cmd /c "net use $($p.DriveLetter) $netPath /u:$($p.Username) $($p.Password)"
}

