<#
.SYNOPSIS
    Disables boot diagnostics on a VM.

.DESCRIPTION
    Disables boot diagnostics on a VM. using input from CSV parameter file.

.NOTES
    Author: Darius James
    Email : josedarius@gmail.com
#>

$params = Import-Csv -Path "./params/Disable-BootDiagnostics.csv"
foreach ($p in $params) {
    try {
        if (-not (Get-AzContext)) { Connect-AzAccount }
        Set-AzVMBootDiagnostics -ResourceGroupName $p.ResourceGroupName -VMName $p.VMName -Disable
        Write-Output "⛔ Boot diagnostics disabled for VM '$($p.VMName)'."
    } catch {
        Write-Error "❌ Error disabling diagnostics: $_"
    }
}
