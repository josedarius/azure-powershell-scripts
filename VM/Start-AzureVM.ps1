<#
.SYNOPSIS
    Starts a specified Azure VM.

.DESCRIPTION
    This script connects to Azure and performs the task of 'starts a specified azure vm.'.
    It takes parameters from a CSV file located in the ./params folder.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

if (-not (Get-AzContext)) { Connect-AzAccount }

$vmParams = Import-Csv -Path "./params/Start-AzureVM.csv"
foreach ($param in $vmParams) {
    Start-AzVM -ResourceGroupName $param.ResourceGroupName -Name $param.VMName
}

