<#
.SYNOPSIS
    Disables boot diagnostics for a VM.

.DESCRIPTION
    Disables boot diagnostics for a VM.
    This script performs the operation using Azure PowerShell and optionally takes input from a CSV file.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

if (-not (Get-AzContext)) { Connect-AzAccount }

$vmParams = Import-Csv -Path "./params/Disable-BootDiagnostics.csv"
foreach ($param in $vmParams) {
    Set-AzVMBootDiagnostics -ResourceGroupName $param.ResourceGroupName -VMName $param.VMName -Disable
}

