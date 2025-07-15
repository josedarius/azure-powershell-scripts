<#
.SYNOPSIS
    Creates a custom route table.

.DESCRIPTION
    Creates a custom route table.
    Reads input from CSV file located in ./params/.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Create-RouteTable.csv"
foreach ($p in $params) {
    New-AzRouteTable -Name $p.RouteTableName -ResourceGroupName $p.ResourceGroupName -Location $p.Location
}

