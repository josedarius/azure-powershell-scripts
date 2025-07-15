<#
.SYNOPSIS
    Enables soft delete for blob storage in a storage account.

.DESCRIPTION
    Enables soft delete for blob storage in a storage account.
    Script reads parameters from CSV and uses Azure PowerShell modules.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Enable-SoftDelete.csv"
foreach ($p in $params) {
    Enable-AzStorageBlobDeleteRetentionPolicy -ResourceGroupName $p.ResourceGroupName -StorageAccountName $p.StorageAccountName -RetentionDays 7
}

