<#
.SYNOPSIS
    Attaches a data disk to a VM.

.DESCRIPTION
    Attaches a data disk to a VM. using input from CSV parameter file.

.NOTES
    Author: Darius James
    Email : josedarius@gmail.com
#>

$params = Import-Csv -Path "./params/Attach-DataDisk.csv"
foreach ($p in $params) {
    try {
        if (-not (Get-AzContext)) { Connect-AzAccount }

        $vm = Get-AzVM -ResourceGroupName $p.ResourceGroupName -Name $p.VMName
        $diskConfig = New-AzDiskConfig -AccountType Standard_LRS -Location $vm.Location -CreateOption Empty -DiskSizeGB $p.DiskSizeGB
        $diskName = "$($p.VMName)-datadisk-$($p.Lun)"
        $disk = New-AzDisk -DiskName $diskName -Disk $diskConfig -ResourceGroupName $p.ResourceGroupName

        Add-AzVMDataDisk -VM $vm -Name $diskName -CreateOption Attach -ManagedDiskId $disk.Id -Lun $p.Lun
        Update-AzVM -VM $vm -ResourceGroupName $p.ResourceGroupName
        Write-Output "✅ Data disk attached to VM '$($p.VMName)'"
    } catch {
        Write-Error "❌ Failed to attach disk: $_"
    }
}
