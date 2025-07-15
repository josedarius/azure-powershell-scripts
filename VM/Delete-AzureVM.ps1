<#
.SYNOPSIS
    Deletes an Azure VM completely.

.DESCRIPTION
    This script connects to Azure and performs the task of 'deletes an azure vm completely.'.
    It takes parameters from a CSV file located in the ./params folder.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

if (-not (Get-AzContext)) { Connect-AzAccount }

$vmParams = Import-Csv -Path "./params/Delete-AzureVM.csv"
foreach ($param in $vmParams) {
    Remove-AzVM -ResourceGroupName $param.ResourceGroupName -Name $param.VMName -Force
}

