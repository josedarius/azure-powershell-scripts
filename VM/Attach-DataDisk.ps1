<#
.SYNOPSIS
    Attaches a new managed data disk to a specified Azure VM.

.DESCRIPTION
    Attaches a new managed data disk to a specified Azure VM.
    This script reads parameters from a CSV file (if required) and executes the task using Azure PowerShell.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

if (-not (Get-AzContext)) { Connect-AzAccount }

$vmParams = Import-Csv -Path "./params/Attach-DataDisk.csv"
foreach ($param in $vmParams) {
    $diskName = "$($param.VMName)-datadisk"
    $diskConfig = New-AzDiskConfig -AccountType Standard_LRS -Location "westeurope" -CreateOption Empty -DiskSizeGB $param.DiskSizeGB
    $dataDisk = New-AzDisk -DiskName $diskName -Disk $diskConfig -ResourceGroupName $param.ResourceGroupName
    $vm = Get-AzVM -ResourceGroupName $param.ResourceGroupName -Name $param.VMName
    $vm = Add-AzVMDataDisk -VM $vm -Name $diskName -CreateOption Attach -ManagedDiskId $dataDisk.Id -Lun 1
    Update-AzVM -VM $vm -ResourceGroupName $param.ResourceGroupName
}

