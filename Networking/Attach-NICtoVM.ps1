<#
.SYNOPSIS
    Attaches a network interface to an existing VM.

.DESCRIPTION
    Attaches a network interface to an existing VM.
    Reads input from CSV file located in ./params/.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Attach-NICtoVM.csv"
foreach ($p in $params) {
    $vm = Get-AzVM -ResourceGroupName $p.ResourceGroupName -Name $p.VMName
    $nic = Get-AzNetworkInterface -ResourceId $p.NICId
    $vm.NetworkProfile.NetworkInterfaces.Add(@{ Id = $nic.Id })
    Update-AzVM -VM $vm -ResourceGroupName $p.ResourceGroupName
}

