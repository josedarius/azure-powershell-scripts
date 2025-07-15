<#
.SYNOPSIS
    Enables boot diagnostics for a VM using a specified storage account.

.DESCRIPTION
    Enables boot diagnostics for a VM using a specified storage account.
    This script performs the operation using Azure PowerShell and optionally takes input from a CSV file.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

if (-not (Get-AzContext)) { Connect-AzAccount }

$vmParams = Import-Csv -Path "./params/Enable-BootDiagnostics.csv"
foreach ($param in $vmParams) {
    Set-AzVMBootDiagnostics -ResourceGroupName $param.ResourceGroupName -VMName $param.VMName `
        -Enable -ResourceUri $param.StorageUri
}

