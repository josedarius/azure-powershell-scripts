<#
.SYNOPSIS
    Deletes a blob from a specified container.

.DESCRIPTION
    Deletes a blob from a specified container.
    Script reads parameters from CSV and uses Azure PowerShell modules.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Delete-Blob.csv"
foreach ($p in $params) {
    $ctx = (Get-AzStorageAccount -ResourceGroupName $p.ResourceGroupName -Name $p.StorageAccountName).Context
    Remove-AzStorageBlob -Container $p.ContainerName -Blob $p.BlobName -Context $ctx
}

