<#
.SYNOPSIS
    Creates a file share in the specified storage account.

.DESCRIPTION
    Creates a file share in the specified storage account.
    Script reads parameters from CSV and uses Azure PowerShell modules.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Create-FileShare.csv"
foreach ($p in $params) {
    $ctx = (Get-AzStorageAccount -Name $p.StorageAccountName -ResourceGroupName $p.ResourceGroupName).Context
    New-AzStorageShare -Name $p.ShareName -Context $ctx -Quota $p.QuotaGB
}

