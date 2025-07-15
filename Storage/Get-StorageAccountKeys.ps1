<#
.SYNOPSIS
    Retrieves access keys for a storage account.

.DESCRIPTION
    Retrieves access keys for a storage account.
    Script reads parameters from CSV and uses Azure PowerShell modules.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Get-StorageAccountKeys.csv"
foreach ($p in $params) {
    Get-AzStorageAccountKey -ResourceGroupName $p.ResourceGroupName -Name $p.StorageAccountName
}

