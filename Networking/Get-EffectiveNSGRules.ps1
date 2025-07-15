<#
.SYNOPSIS
    Gets effective NSG rules for a network interface.

.DESCRIPTION
    Gets effective NSG rules for a network interface.
    Reads input from CSV file located in ./params/.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Get-EffectiveNSGRules.csv"
foreach ($p in $params) {
    Get-AzEffectiveNetworkSecurityGroup -NetworkInterfaceName $p.NICName -ResourceGroupName $p.ResourceGroupName
}

