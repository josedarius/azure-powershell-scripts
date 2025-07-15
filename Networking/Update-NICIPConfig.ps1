<#
.SYNOPSIS
    Updates IP configuration for a NIC (e.g., change IP allocation method).

.DESCRIPTION
    Updates IP configuration for a NIC (e.g., change IP allocation method).
    Reads input from CSV file located in ./params/.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Update-NICIPConfig.csv"
foreach ($p in $params) {
    $nic = Get-AzNetworkInterface -Name $p.NICName -ResourceGroupName $p.ResourceGroupName
    $nic.IpConfigurations[0].PrivateIpAllocationMethod = $p.PrivateIPAllocationMethod
    Set-AzNetworkInterface -NetworkInterface $nic
}

