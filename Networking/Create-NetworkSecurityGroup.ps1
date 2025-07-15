<#
.SYNOPSIS
    Creates a network security group with default rules.

.DESCRIPTION
    Creates a network security group with default rules.
    Uses parameter input from CSV file.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Create-NetworkSecurityGroup.csv"
foreach ($p in $params) {
    New-AzNetworkSecurityGroup -Name $p.NSGName -ResourceGroupName $p.ResourceGroupName -Location $p.Location
}

