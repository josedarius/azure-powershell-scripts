<#
.SYNOPSIS
    Restarts a virtual machine.

.DESCRIPTION
    Restarts a virtual machine. using input from CSV parameter file.

.NOTES
    Author: Darius James
    Email : josedarius@gmail.com
#>

$params = Import-Csv -Path "./params/Restart-AzureVM.csv"
foreach ($p in $params) {
    try {
        if (-not (Get-AzContext)) { Connect-AzAccount }
        Write-Output "🔁 Restarting VM '$($p.VMName)'..."
        Restart-AzVM -ResourceGroupName $p.ResourceGroupName -Name $p.VMName
        Write-Output "✅ VM '$($p.VMName)' restarted successfully."
    } catch {
        Write-Error "❌ Failed to restart VM: $_"
    }
}
