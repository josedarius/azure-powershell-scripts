<#
.SYNOPSIS
    Creates a general-purpose v2 Azure Storage Account.

.DESCRIPTION
    Creates a general-purpose v2 Azure Storage Account.
    Reads parameters from CSV located in ./params/ and executes Azure PowerShell operations.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Create-StorageAccount.csv"
foreach ($p in $params) {
    New-AzStorageAccount -ResourceGroupName $p.ResourceGroupName -Name $p.StorageAccountName `
        -Location $p.Location -SkuName $p.SkuName -Kind $p.Kind
}

