<#
.SYNOPSIS
    Uploads a local file to a blob container.

.DESCRIPTION
    Uploads a local file to a blob container.
    Reads parameters from CSV located in ./params/ and executes Azure PowerShell operations.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Upload-BlobFromFile.csv"
foreach ($p in $params) {
    $ctx = (Get-AzStorageAccount -Name $p.StorageAccountName -ResourceGroupName $p.ResourceGroupName).Context
    Set-AzStorageBlobContent -File $p.FilePath -Container $p.ContainerName -Context $ctx
}

