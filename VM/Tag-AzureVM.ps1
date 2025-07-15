<#
.SYNOPSIS
    Adds or updates tags for a VM.

.DESCRIPTION
    Adds or updates tags for a VM.
    This script performs the operation using Azure PowerShell and optionally takes input from a CSV file.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

if (-not (Get-AzContext)) { Connect-AzAccount }

$vmParams = Import-Csv -Path "./params/Tag-AzureVM.csv"
foreach ($param in $vmParams) {
    $vm = Get-AzVM -ResourceGroupName $param.ResourceGroupName -Name $param.VMName
    $vm.Tags[$param.TagKey] = $param.TagValue
    Set-AzResource -ResourceId $vm.Id -Tag $vm.Tags -Force
}

