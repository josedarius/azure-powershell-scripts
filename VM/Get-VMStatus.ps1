<#
.SYNOPSIS
    Retrieves the power status of the specified Azure VM.

.DESCRIPTION
    Retrieves the power status of the specified Azure VM.
    This script reads parameters from a CSV file (if required) and executes the task using Azure PowerShell.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

if (-not (Get-AzContext)) { Connect-AzAccount }

$vmParams = Import-Csv -Path "./params/Get-VMStatus.csv"
foreach ($param in $vmParams) {
    $status = Get-AzVM -ResourceGroupName $param.ResourceGroupName -Name $param.VMName -Status
    Write-Output "VM: $($param.VMName), Status: $($status.Statuses[1].DisplayStatus)"
}

