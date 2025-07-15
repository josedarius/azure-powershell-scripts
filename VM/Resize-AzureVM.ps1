<#
.SYNOPSIS
    Resizes an existing Azure VM to a new size.

.DESCRIPTION
    Resizes an existing Azure VM to a new size.
    This script reads parameters from a CSV file (if required) and executes the task using Azure PowerShell.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

if (-not (Get-AzContext)) { Connect-AzAccount }

$vmParams = Import-Csv -Path "./params/Resize-AzureVM.csv"
foreach ($param in $vmParams) {
    $vm = Get-AzVM -ResourceGroupName $param.ResourceGroupName -Name $param.VMName
    $vm.HardwareProfile.VmSize = $param.NewSize
    Update-AzVM -ResourceGroupName $param.ResourceGroupName -VM $vm
}

