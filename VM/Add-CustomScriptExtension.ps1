<#
.SYNOPSIS
    Installs a custom script extension on a VM to run a local or remote script.

.DESCRIPTION
    Installs a custom script extension on a VM to run a local or remote script.
    This script performs the operation using Azure PowerShell and optionally takes input from a CSV file.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

if (-not (Get-AzContext)) { Connect-AzAccount }

$vmParams = Import-Csv -Path "./params/Add-CustomScriptExtension.csv"
foreach ($param in $vmParams) {
    Set-AzVMCustomScriptExtension -ResourceGroupName $param.ResourceGroupName -VMName $param.VMName `
        -Location "westeurope" -FileUri $param.FileUri -Run $param.CommandToExecute `
        -Name "CustomScriptExtension" -Publisher "Microsoft.Compute" -Type "CustomScriptExtension" `
        -TypeHandlerVersion "1.9"
}

