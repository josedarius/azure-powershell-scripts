<#
.SYNOPSIS
    Redeploys a VM to a new host to resolve underlying platform issues.

.DESCRIPTION
    Redeploys a VM to a new host to resolve underlying platform issues.
    This script performs the operation using Azure PowerShell and optionally takes input from a CSV file.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

if (-not (Get-AzContext)) { Connect-AzAccount }

$vmParams = Import-Csv -Path "./params/Redeploy-VM.csv"
foreach ($param in $vmParams) {
    Set-AzVM -ResourceGroupName $param.ResourceGroupName -Name $param.VMName -Redeploy
}

