<#
.SYNOPSIS
    Restarts a VM using Azure PowerShell.

.DESCRIPTION
    This script connects to Azure and performs the task of 'restarts a vm using azure powershell.'.
    It takes parameters from a CSV file located in the ./params folder.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

if (-not (Get-AzContext)) { Connect-AzAccount }

$vmParams = Import-Csv -Path "./params/Restart-AzureVM.csv"
foreach ($param in $vmParams) {
    Restart-AzVM -ResourceGroupName $param.ResourceGroupName -Name $param.VMName
}

