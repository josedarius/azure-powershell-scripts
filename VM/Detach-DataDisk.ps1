<#
.SYNOPSIS
    Detaches a data disk from a specified Azure VM.

.DESCRIPTION
    Detaches a data disk from a specified Azure VM.
    This script reads parameters from a CSV file (if required) and executes the task using Azure PowerShell.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

if (-not (Get-AzContext)) { Connect-AzAccount }

$vmParams = Import-Csv -Path "./params/Detach-DataDisk.csv"
foreach ($param in $vmParams) {
    $vm = Get-AzVM -ResourceGroupName $param.ResourceGroupName -Name $param.VMName
    $vm = Remove-AzVMDataDisk -VM $vm -Name $param.DiskName
    Update-AzVM -VM $vm -ResourceGroupName $param.ResourceGroupName
}

