<#
.SYNOPSIS
    Enables blob versioning in the specified storage account.

.DESCRIPTION
    Enables blob versioning in the specified storage account.
    Script reads parameters from CSV and uses Azure PowerShell modules.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Enable-Versioning.csv"
foreach ($p in $params) {
    Update-AzStorageBlobServiceProperty -ResourceGroupName $p.ResourceGroupName -AccountName $p.StorageAccountName -EnableVersioning $true
}

