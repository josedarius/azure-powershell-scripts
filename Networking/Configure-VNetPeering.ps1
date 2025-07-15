<#
.SYNOPSIS
    Creates VNet peering between two virtual networks.

.DESCRIPTION
    Creates VNet peering between two virtual networks.
    Reads input from CSV file located in ./params/.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Configure-VNetPeering.csv"
foreach ($p in $params) {
    $vnet1 = Get-AzVirtualNetwork -Name $p.SourceVNet -ResourceGroupName $p.SourceRG
    $vnet2 = Get-AzVirtualNetwork -Name $p.DestVNet -ResourceGroupName $p.DestRG
    Add-AzVirtualNetworkPeering -Name $p.PeeringName -VirtualNetwork $vnet1 -RemoteVirtualNetworkId $vnet2.Id -AllowForwardedTraffic
}

