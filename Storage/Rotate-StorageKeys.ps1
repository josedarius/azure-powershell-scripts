<#
.SYNOPSIS
    Regenerates primary or secondary storage account key.

.DESCRIPTION
    Regenerates primary or secondary storage account key.
    Script reads parameters from CSV and uses Azure PowerShell modules.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Rotate-StorageKeys.csv"
foreach ($p in $params) {
    New-AzStorageAccountKey -ResourceGroupName $p.ResourceGroupName -Name $p.StorageAccountName -KeyName $p.KeyName
}

