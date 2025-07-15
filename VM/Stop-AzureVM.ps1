<#
.SYNOPSIS
    Stops (deallocates) a running Azure VM.

.DESCRIPTION
    This script connects to Azure and performs the task of 'stops (deallocates) a running azure vm.'.
    It takes parameters from a CSV file located in the ./params folder.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

if (-not (Get-AzContext)) { Connect-AzAccount }

$vmParams = Import-Csv -Path "./params/Stop-AzureVM.csv"
foreach ($param in $vmParams) {
    Stop-AzVM -ResourceGroupName $param.ResourceGroupName -Name $param.VMName -Force
}

