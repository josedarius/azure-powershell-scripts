<#
.SYNOPSIS
    Lists extensions installed on a VM.

.DESCRIPTION
    Lists extensions installed on a VM. using input from CSV parameter file.

.NOTES
    Author: Darius James
    Email : josedarius@gmail.com
#>

$params = Import-Csv -Path "./params/List-VMExtensions.csv"
foreach ($p in $params) {
    try {
        if (-not (Get-AzContext)) { Connect-AzAccount }
        Get-AzVMExtension -ResourceGroupName $p.ResourceGroupName -VMName $p.VMName |
        Format-Table Name, Type, ProvisioningState
    } catch {
        Write-Error "❌ Failed to list extensions: $_"
    }
}
