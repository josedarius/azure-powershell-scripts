<#
.SYNOPSIS
    Creates a NIC with optional NSG and Public IP.

.DESCRIPTION
    Creates a NIC with optional NSG and Public IP.
    Uses parameter input from CSV file.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Create-NIC.csv"
foreach ($p in $params) {
    $nic = New-AzNetworkInterface -Name $p.NICName -ResourceGroupName $p.ResourceGroupName `
        -Location $p.Location -SubnetId $p.SubnetId `
        -NetworkSecurityGroupId $p.NSGId -PublicIpAddressId $p.PublicIPId
}

