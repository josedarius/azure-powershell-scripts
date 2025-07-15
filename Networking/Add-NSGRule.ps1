<#
.SYNOPSIS
    Adds a security rule to an existing NSG.

.DESCRIPTION
    Adds a security rule to an existing NSG.
    Uses parameter input from CSV file.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Add-NSGRule.csv"
foreach ($p in $params) {
    $rule = Add-AzNetworkSecurityRuleConfig -Name $p.RuleName -NetworkSecurityGroup `
        (Get-AzNetworkSecurityGroup -Name $p.NSGName -ResourceGroupName $p.ResourceGroupName) `
        -Protocol $p.Protocol -Direction Inbound -Priority $p.Priority -SourceAddressPrefix * -SourcePortRange * `
        -DestinationAddressPrefix * -DestinationPortRange $p.Port -Access Allow
    Set-AzNetworkSecurityGroup -NetworkSecurityGroup $rule
}

