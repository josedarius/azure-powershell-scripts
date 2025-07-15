<#
.SYNOPSIS
    Lists all extensions installed on a specified VM.

.DESCRIPTION
    Lists all extensions installed on a specified VM.
    This script performs the operation using Azure PowerShell and optionally takes input from a CSV file.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

if (-not (Get-AzContext)) { Connect-AzAccount }

$vmParams = Import-Csv -Path "./params/List-VMExtensions.csv"
foreach ($param in $vmParams) {
    $extensions = Get-AzVMExtension -ResourceGroupName $param.ResourceGroupName -VMName $param.VMName
    foreach ($ext in $extensions) {
        Write-Output "VM: $($param.VMName) - Extension: $($ext.Name), Publisher: $($ext.Publisher)"
    }
}

