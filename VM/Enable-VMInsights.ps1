<#
.SYNOPSIS
    Enables VM insights by linking to a Log Analytics workspace.

.DESCRIPTION
    Enables VM insights by linking to a Log Analytics workspace.
    This script performs the operation using Azure PowerShell and optionally takes input from a CSV file.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

if (-not (Get-AzContext)) { Connect-AzAccount }

$vmParams = Import-Csv -Path "./params/Enable-VMInsights.csv"
foreach ($param in $vmParams) {
    Set-AzVMExtension -ResourceId $param.ResourceId `
        -Name "DependencyAgentWindows" `
        -Publisher "Microsoft.Azure.Monitoring.DependencyAgent" `
        -Type "DependencyAgentWindows" `
        -TypeHandlerVersion "9.10" `
        -Settings @{} -Location "westeurope"
}

