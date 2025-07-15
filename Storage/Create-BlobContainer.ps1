<#
.SYNOPSIS
    Creates a new blob container in a storage account.

.DESCRIPTION
    Creates a new blob container in a storage account.
    Reads parameters from CSV located in ./params/ and executes Azure PowerShell operations.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Create-BlobContainer.csv"
foreach ($p in $params) {
    $ctx = (Get-AzStorageAccount -Name $p.StorageAccountName -ResourceGroupName $p.ResourceGroupName).Context
    New-AzStorageContainer -Name $p.ContainerName -Context $ctx
}

