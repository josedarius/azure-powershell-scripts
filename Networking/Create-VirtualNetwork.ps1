<#
.SYNOPSIS
    Creates a virtual network and subnets.

.DESCRIPTION
    Creates a virtual network and subnets.
    Uses parameter input from CSV file.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Create-VirtualNetwork.csv"
foreach ($p in $params) {
    $subnetConfig = New-AzVirtualNetworkSubnetConfig -Name $p.SubnetName -AddressPrefix $p.SubnetPrefix
    New-AzVirtualNetwork -Name $p.VNetName -ResourceGroupName $p.ResourceGroupName -Location $p.Location `
        -AddressPrefix $p.AddressPrefix -Subnet $subnetConfig
}

