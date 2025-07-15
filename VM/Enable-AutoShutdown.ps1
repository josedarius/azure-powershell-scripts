<#
.SYNOPSIS
    Enables auto-shutdown on a VM.

.DESCRIPTION
    Enables auto-shutdown on a VM. using input from CSV parameter file.

.NOTES
    Author: Darius James
    Email : josedarius@gmail.com
#>

$params = Import-Csv -Path "./params/Enable-AutoShutdown.csv"
foreach ($p in $params) {
    try {
        if (-not (Get-AzContext)) { Connect-AzAccount }
        Set-AzVMAutoShutdown -ResourceGroupName $p.ResourceGroupName -VMName $p.VMName -Time $p.Time -TimeZone "UTC"
        Write-Output "✅ Auto-shutdown enabled at $($p.Time) UTC"
    } catch {
        Write-Error "❌ Failed to set auto-shutdown: $_"
    }
}
