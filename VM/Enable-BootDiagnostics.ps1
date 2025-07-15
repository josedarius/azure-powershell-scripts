<#
.SYNOPSIS
    Enables boot diagnostics on a VM.

.DESCRIPTION
    Enables boot diagnostics on a VM. using input from CSV parameter file.

.NOTES
    Author: Darius James
    Email : josedarius@gmail.com
#>

$params = Import-Csv -Path "./params/Enable-BootDiagnostics.csv"
foreach ($p in $params) {
    try {
        if (-not (Get-AzContext)) { Connect-AzAccount }
        Set-AzVMBootDiagnostics -ResourceGroupName $p.ResourceGroupName -VMName $p.VMName `
            -Enable -ResourceUri $p.StorageUri
        Write-Output "🩺 Boot diagnostics enabled for VM '$($p.VMName)'."
    } catch {
        Write-Error "❌ Error enabling diagnostics: $_"
    }
}
