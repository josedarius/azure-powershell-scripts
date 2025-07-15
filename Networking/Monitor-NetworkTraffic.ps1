<#
.SYNOPSIS
    Enables NSG flow logging in a storage account.

.DESCRIPTION
    Enables NSG flow logging in a storage account.
    Reads input from CSV file located in ./params/.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Monitor-NetworkTraffic.csv"
foreach ($p in $params) {
    Set-AzNetworkWatcherConfigFlowLog -TargetResourceId (Get-AzNetworkSecurityGroup -Name $p.NSGName -ResourceGroupName $p.ResourceGroupName).Id `
        -StorageId $p.StorageAccountId -Enabled $true -FormatType JSON
}

