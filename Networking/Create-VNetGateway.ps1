<#
.SYNOPSIS
    Creates a Virtual Network Gateway for site-to-site VPN.

.DESCRIPTION
    Creates a Virtual Network Gateway for site-to-site VPN.
    Parameters are supplied via ./params/ CSV file.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Create-VNetGateway.csv"
foreach ($p in $params) {
    $subnet = Get-AzVirtualNetworkSubnetConfig -Name $p.GatewaySubnetName `
        -VirtualNetwork (Get-AzVirtualNetwork -Name $p.VNetName -ResourceGroupName $p.ResourceGroupName)

    $gwSubnetId = $subnet.Id
    $pubIP = New-AzPublicIpAddress -Name $p.PublicIPName -ResourceGroupName $p.ResourceGroupName -Location $p.Location `
        -AllocationMethod Dynamic -Sku Basic

    $ipConfig = New-AzVirtualNetworkGatewayIpConfig -Name "gwIpConfig" -SubnetId $gwSubnetId -PublicIpAddressId $pubIP.Id

    New-AzVirtualNetworkGateway -Name $p.GatewayName -ResourceGroupName $p.ResourceGroupName -Location $p.Location `
        -IpConfigurations $ipConfig -GatewayType Vpn -VpnType RouteBased -EnableBgp $false -GatewaySku VpnGw1
}

