<#
.SYNOPSIS
    Creates a private endpoint to access Azure services privately.

.DESCRIPTION
    Creates a private endpoint to access Azure services privately.
    Reads input from CSV file located in ./params/.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Create-PrivateEndpoint.csv"
foreach ($p in $params) {
    $connection = New-AzPrivateLinkServiceConnection -Name $p.PEName -PrivateLinkServiceId $p.ServiceResourceId -GroupId $p.GroupId
    New-AzPrivateEndpoint -Name $p.PEName -ResourceGroupName $p.ResourceGroupName -Location $p.Location `
        -SubnetId $p.SubnetId -PrivateLinkServiceConnection $connection
}

