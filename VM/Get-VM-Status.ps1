<#
.SYNOPSIS
    Gets the power status of a VM.

.DESCRIPTION
    Gets the power status of a VM. using input from CSV parameter file.

.NOTES
    Author: Darius James
    Email : josedarius@gmail.com
#>

$params = Import-Csv -Path "./params/Get-VM-Status.csv"
foreach ($p in $params) {
    try {
        if (-not (Get-AzContext)) { Connect-AzAccount }
        $status = (Get-AzVM -ResourceGroupName $p.ResourceGroupName -Name $p.VMName -Status).Statuses |
                  Where-Object { $_.Code -like "PowerState*" }
        Write-Output "⚡ VM '$($p.VMName)' status: $($status.DisplayStatus)"
    } catch {
        Write-Error "❌ Failed to get status: $_"
    }
}
