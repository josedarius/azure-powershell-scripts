<#
.SYNOPSIS
    Creates a Basic Azure Load Balancer with frontend, backend pool, health probe, and rule.

.DESCRIPTION
    Creates a Basic Azure Load Balancer with frontend, backend pool, health probe, and rule.
    Parameters are supplied via ./params/ CSV file.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Create-LoadBalancer.csv"
foreach ($p in $params) {
    $publicIP = New-AzPublicIpAddress -Name $p.PublicIPName -ResourceGroupName $p.ResourceGroupName `
        -Location $p.Location -AllocationMethod Static -Sku Basic

    $frontend = New-AzLoadBalancerFrontendIpConfig -Name $p.FrontendIPName -PublicIpAddress $publicIP
    $backend = New-AzLoadBalancerBackendAddressPoolConfig -Name $p.BackendPoolName

    $probe = New-AzLoadBalancerProbeConfig -Name "tcpProbe" -Protocol Tcp -Port 80 -IntervalInSeconds 15 -ProbeCount 2
    $inboundRule = New-AzLoadBalancerRuleConfig -Name "webRule" -FrontendIpConfiguration $frontend `
        -BackendAddressPool $backend -Probe $probe -Protocol Tcp -FrontendPort 80 -BackendPort 80

    New-AzLoadBalancer -Name $p.LBName -ResourceGroupName $p.ResourceGroupName -Location $p.Location `
        -FrontendIpConfigurations $frontend -BackendAddressPools $backend -LoadBalancingRules $inboundRule -Probes $probe
}

