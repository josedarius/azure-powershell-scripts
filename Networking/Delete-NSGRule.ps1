<#
.SYNOPSIS
    Deletes a specific rule from an NSG.

.DESCRIPTION
    Deletes a specific rule from an NSG.
    Reads input from CSV file located in ./params/.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Delete-NSGRule.csv"
foreach ($p in $params) {
    $nsg = Get-AzNetworkSecurityGroup -Name $p.NSGName -ResourceGroupName $p.ResourceGroupName
    $nsg.SecurityRules.Remove($nsg.SecurityRules | Where-Object { $_.Name -eq $p.RuleName })
    Set-AzNetworkSecurityGroup -NetworkSecurityGroup $nsg
}

