<#
.SYNOPSIS
    Lists all blobs in a specific container.

.DESCRIPTION
    Lists all blobs in a specific container.
    Reads parameters from CSV located in ./params/ and executes Azure PowerShell operations.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/List-BlobsInContainer.csv"
foreach ($p in $params) {
    $ctx = (Get-AzStorageAccount -Name $p.StorageAccountName -ResourceGroupName $p.ResourceGroupName).Context
    Get-AzStorageBlob -Container $p.ContainerName -Context $ctx | Select-Object Name, Length, BlobType
}

