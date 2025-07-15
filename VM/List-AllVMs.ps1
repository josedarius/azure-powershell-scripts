<#
.SYNOPSIS
    Lists all VMs in the subscription.

.DESCRIPTION
    Lists all VMs in the subscription. using input from CSV parameter file.

.NOTES
    Author: Darius James
    Email : josedarius@gmail.com
#>

try {
    if (-not (Get-AzContext)) { Connect-AzAccount }
    $vms = Get-AzVM
    $vms | Format-Table Name, ResourceGroupName, Location, ProvisioningState
} catch {
    Write-Error "❌ Failed to list VMs: $_"
}
