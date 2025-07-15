<#
.SYNOPSIS
    Creates an Azure Application Gateway with basic frontend, backend pool, HTTP listener, and rule.

.DESCRIPTION
    Creates an Azure Application Gateway with basic frontend, backend pool, HTTP listener, and rule.
    Parameters are supplied via ./params/ CSV file.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Create-AppGateway.csv"
foreach ($p in $params) {
    $subnet = Get-AzVirtualNetworkSubnetConfig -Name $p.SubnetName `
        -VirtualNetwork (Get-AzVirtualNetwork -Name $p.VNetName -ResourceGroupName $p.ResourceGroupName)
    $publicIP = New-AzPublicIpAddress -ResourceGroupName $p.ResourceGroupName -Name $p.PublicIPName `
        -Location $p.Location -AllocationMethod Static -Sku Standard

    $frontendIP = New-AzApplicationGatewayFrontendIPConfig -Name "appGatewayFrontendIP" -PublicIPAddress $publicIP
    $frontendPort = New-AzApplicationGatewayFrontendPort -Name "appGatewayFrontendPort" -Port $p.FrontendPort
    $backendPool = New-AzApplicationGatewayBackendAddressPool -Name "appGatewayBackendPool" -BackendIPAddresses $p.BackendIP
    $probe = New-AzApplicationGatewayProbeConfig -Name "appGatewayProbe" -Protocol Http -Path "/" `
        -Interval 30 -Timeout 30 -UnhealthyThreshold 3 -PickHostNameFromBackendHttpSettings $false -MinServers 0

    $backendHttpSettings = New-AzApplicationGatewayBackendHttpSettings -Name "appGatewayBackendHttpSettings" `
        -Port $p.FrontendPort -Protocol Http -CookieBasedAffinity Disabled -Probe $probe

    $listener = New-AzApplicationGatewayHttpListener -Name "appGatewayHttpListener" `
        -FrontendIPConfiguration $frontendIP -FrontendPort $frontendPort -Protocol Http

    $rule = New-AzApplicationGatewayRequestRoutingRule -Name "rule1" -RuleType Basic `
        -HttpListener $listener -BackendAddressPool $backendPool -BackendHttpSettings $backendHttpSettings

    New-AzApplicationGateway -Name $p.AppGatewayName -ResourceGroupName $p.ResourceGroupName `
        -Location $p.Location -BackendAddressPools $backendPool -BackendHttpSettingsCollection $backendHttpSettings `
        -FrontendIPConfigurations $frontendIP -GatewayIPConfigurations (New-AzApplicationGatewayIPConfiguration -Name "appGatewayIpConfig" -Subnet $subnet) `
        -FrontendPorts $frontendPort -HttpListeners $listener -RequestRoutingRules $rule `
        -Sku Standard_Small -Tier Standard -Probe $probe
}

