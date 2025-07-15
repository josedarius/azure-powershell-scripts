<#
.SYNOPSIS
    Associates a route table to a subnet.

.DESCRIPTION
    Associates a route table to a subnet.
    Reads input from CSV file located in ./params/.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Associate-RouteTableToSubnet.csv"
foreach ($p in $params) {
    $subnet = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork (Get-AzVirtualNetwork -Name $p.VNetName -ResourceGroupName $p.ResourceGroupName) -Name $p.SubnetName
    $route = Get-AzRouteTable -Name $p.RouteTableName -ResourceGroupName $p.ResourceGroupName
    Set-AzVirtualNetworkSubnetConfig -VirtualNetwork (Get-AzVirtualNetwork -Name $p.VNetName -ResourceGroupName $p.ResourceGroupName) `
        -Name $p.SubnetName -AddressPrefix $subnet.AddressPrefix -RouteTable $route
}

