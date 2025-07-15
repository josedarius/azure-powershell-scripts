<#
.SYNOPSIS
    Downloads a blob from a container to local file.

.DESCRIPTION
    Downloads a blob from a container to local file.
    Reads parameters from CSV located in ./params/ and executes Azure PowerShell operations.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Download-BlobToFile.csv"
foreach ($p in $params) {
    $ctx = (Get-AzStorageAccount -Name $p.StorageAccountName -ResourceGroupName $p.ResourceGroupName).Context
    Get-AzStorageBlobContent -Blob $p.BlobName -Container $p.ContainerName -Destination $p.DownloadPath -Context $ctx
}

