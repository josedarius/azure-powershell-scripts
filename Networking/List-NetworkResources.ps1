<#
.SYNOPSIS
    Lists all VNETs, NSGs, NICs in a resource group.

.DESCRIPTION
    Lists all VNETs, NSGs, NICs in a resource group.
    Reads input from CSV file located in ./params/.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/List-NetworkResources.csv"
foreach ($p in $params) {
    Get-AzVirtualNetwork -ResourceGroupName $p.ResourceGroupName
    Get-AzNetworkSecurityGroup -ResourceGroupName $p.ResourceGroupName
    Get-AzNetworkInterface -ResourceGroupName $p.ResourceGroupName
}

