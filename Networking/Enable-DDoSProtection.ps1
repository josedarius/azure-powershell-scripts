<#
.SYNOPSIS
    Enables DDoS standard protection on a VNet.

.DESCRIPTION
    Enables DDoS standard protection on a VNet.
    Reads input from CSV file located in ./params/.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Enable-DDoSProtection.csv"
foreach ($p in $params) {
    $vnet = Get-AzVirtualNetwork -Name $p.VNetName -ResourceGroupName $p.ResourceGroupName
    $vnet.DdosProtectionPlan = @{ Id = $p.DDoSPlanId }
    $vnet.EnableDdosProtection = $true
    Set-AzVirtualNetwork -VirtualNetwork $vnet
}

