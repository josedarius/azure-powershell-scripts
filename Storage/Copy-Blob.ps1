<#
.SYNOPSIS
    Copies a blob from one container to another.

.DESCRIPTION
    Copies a blob from one container to another.
    Script reads parameters from CSV and uses Azure PowerShell modules.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Copy-Blob.csv"
foreach ($p in $params) {
    $ctx = (Get-AzStorageAccount -Name $p.SourceAccount -ResourceGroupName $p.ResourceGroupName).Context
    Start-AzStorageBlobCopy -SrcContainer $p.SourceContainer -SrcBlob $p.BlobName -DestContainer $p.DestContainer -DestBlob $p.BlobName -Context $ctx
}

