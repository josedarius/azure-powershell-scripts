<#
.SYNOPSIS
    Creates a new Azure VM with network interface, VNet, and public IP.

.DESCRIPTION
    This script connects to Azure and performs the task of 'creates a new azure vm with network interface, vnet, and public ip.'.
    It takes parameters from a CSV file located in the ./params folder.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

if (-not (Get-AzContext)) { Connect-AzAccount }

$vmParams = Import-Csv -Path "./params/Create-AzureVM.csv"
foreach ($p in $vmParams) {
    $subnetConfig = New-AzVirtualNetworkSubnetConfig -Name "default" -AddressPrefix "10.0.0.0/24"
    $vnet = New-AzVirtualNetwork -Name "$($p.VMName)-vnet" -ResourceGroupName $p.ResourceGroupName `
             -Location $p.Location -AddressPrefix "10.0.0.0/16" -Subnet $subnetConfig
    $pip = New-AzPublicIpAddress -Name "$($p.VMName)-pip" -ResourceGroupName $p.ResourceGroupName `
             -Location $p.Location -AllocationMethod Dynamic
    $nic = New-AzNetworkInterface -Name "$($p.VMName)-nic" -ResourceGroupName $p.ResourceGroupName `
             -Location $p.Location -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id
    $cred = New-Object System.Management.Automation.PSCredential ($p.AdminUsername, (ConvertTo-SecureString $p.AdminPassword -AsPlainText -Force))
    $vmConfig = New-AzVMConfig -VMName $p.VMName -VMSize $p.VMSize | `
                Set-AzVMOperatingSystem -Windows -ComputerName $p.VMName -Credential $cred | `
                Set-AzVMSourceImage -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" `
                -Skus "2019-Datacenter" -Version "latest" | `
                Add-AzVMNetworkInterface -Id $nic.Id
    New-AzVM -ResourceGroupName $p.ResourceGroupName -Location $p.Location -VM $vmConfig
}

