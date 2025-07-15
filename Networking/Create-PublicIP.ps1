<#
.SYNOPSIS
    Creates a public IP address resource.

.DESCRIPTION
    Creates a public IP address resource.
    Uses parameter input from CSV file.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Create-PublicIP.csv"
foreach ($p in $params) {
    New-AzPublicIpAddress -Name $p.IPName -ResourceGroupName $p.ResourceGroupName -Location $p.Location `
        -AllocationMethod $p.AllocationMethod -Sku Basic
}

