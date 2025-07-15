<#
.SYNOPSIS
    Detaches a data disk from a VM.

.DESCRIPTION
    Detaches a data disk from a VM. using input from CSV parameter file.

.NOTES
    Author: Darius James
    Email : josedarius@gmail.com
#>

$params = Import-Csv -Path "./params/Detach-DataDisk.csv"
foreach ($p in $params) {
    try {
        if (-not (Get-AzContext)) { Connect-AzAccount }
        $vm = Get-AzVM -ResourceGroupName $p.ResourceGroupName -Name $p.VMName
        Remove-AzVMDataDisk -VM $vm -Name $p.DiskName
        Update-AzVM -VM $vm -ResourceGroupName $p.ResourceGroupName
        Write-Output "✅ Data disk '$($p.DiskName)' detached from VM '$($p.VMName)'"
    } catch {
        Write-Error "❌ Failed to detach disk: $_"
    }
}
