<#
.SYNOPSIS
    Adds a route to an existing route table.

.DESCRIPTION
    Adds a route to an existing route table.
    Reads input from CSV file located in ./params/.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Add-Route.csv"
foreach ($p in $params) {
    $table = Get-AzRouteTable -Name $p.RouteTableName -ResourceGroupName $p.ResourceGroupName
    Add-AzRouteConfig -Name $p.RouteName -AddressPrefix $p.AddressPrefix -NextHopType $p.NextHopType -RouteTable $table
    Set-AzRouteTable -RouteTable $table
}

