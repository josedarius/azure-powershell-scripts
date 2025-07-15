<#
.SYNOPSIS
    Lists all Azure VMs in the current subscription.

.DESCRIPTION
    Lists all Azure VMs in the current subscription.
    This script reads parameters from a CSV file (if required) and executes the task using Azure PowerShell.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

if (-not (Get-AzContext)) { Connect-AzAccount }

$vms = Get-AzVM
foreach ($vm in $vms) {
    Write-Output "VM Name: $($vm.Name), Resource Group: $($vm.ResourceGroupName), Location: $($vm.Location)"
}

