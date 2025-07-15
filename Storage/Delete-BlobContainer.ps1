<#
.SYNOPSIS
    Deletes a blob container from a storage account.

.DESCRIPTION
    Deletes a blob container from a storage account.
    Script reads parameters from CSV and uses Azure PowerShell modules.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Delete-BlobContainer.csv"
foreach ($p in $params) {
    $ctx = (Get-AzStorageAccount -Name $p.StorageAccountName -ResourceGroupName $p.ResourceGroupName).Context
    Remove-AzStorageContainer -Name $p.ContainerName -Context $ctx -Force
}

