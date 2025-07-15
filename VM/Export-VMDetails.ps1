<#
.SYNOPSIS
    Exports VM details to a CSV file.

.DESCRIPTION
    Exports VM details to a CSV file. using input from CSV parameter file.

.NOTES
    Author: Darius James
    Email : josedarius@gmail.com
#>

$params = Import-Csv -Path "./params/Export-VMDetails.csv"
foreach ($p in $params) {
    try {
        if (-not (Get-AzContext)) { Connect-AzAccount }
        $vms = Get-AzVM
        $output = $vms | Select-Object Name, ResourceGroupName, Location, VmSize, ProvisioningState
        $output | Export-Csv -Path $p.OutputPath -NoTypeInformation
        Write-Output "✅ VM details exported to $($p.OutputPath)"
    } catch {
        Write-Error "❌ Failed to export VM details: $_"
    }
}
