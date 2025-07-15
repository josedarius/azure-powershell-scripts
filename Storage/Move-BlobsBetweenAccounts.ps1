<#
.SYNOPSIS
    Moves all blobs from one storage account/container to another.

.DESCRIPTION
    Moves all blobs from one storage account/container to another.
    Script reads parameters from CSV and uses Azure PowerShell modules.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Move-BlobsBetweenAccounts.csv"
foreach ($p in $params) {
    $srcCtx = (Get-AzStorageAccount -Name $p.SourceAccount -ResourceGroupName $p.SourceRG).Context
    $dstCtx = (Get-AzStorageAccount -Name $p.DestAccount -ResourceGroupName $p.DestRG).Context
    $blobs = Get-AzStorageBlob -Container $p.SourceContainer -Context $srcCtx
    foreach ($b in $blobs) {
        Start-AzStorageBlobCopy -AbsoluteUri $b.ICloudBlob.Uri.AbsoluteUri -DestContainer $p.DestContainer -DestBlob $b.Name -Context $dstCtx
    }
}

