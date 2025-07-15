<#
.SYNOPSIS
    Exports details of all VMs to a CSV file.

.DESCRIPTION
    Exports details of all VMs to a CSV file.
    This script performs the operation using Azure PowerShell and optionally takes input from a CSV file.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

if (-not (Get-AzContext)) { Connect-AzAccount }

$vms = Get-AzVM
$results = @()
foreach ($vm in $vms) {
    $status = Get-AzVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name -Status
    $results += [PSCustomObject]@{
        VMName = $vm.Name
        ResourceGroup = $vm.ResourceGroupName
        Location = $vm.Location
        Size = $vm.HardwareProfile.VmSize
        Status = $status.Statuses[1].DisplayStatus
    }
}
$results | Export-Csv -Path "./params/Exported-VMDetails.csv" -NoTypeInformation

