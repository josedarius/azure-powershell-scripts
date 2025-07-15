<#
.SYNOPSIS
    Creates an Azure VM with full networking stack.

.DESCRIPTION
    Reads input parameters from a CSV file and creates a VM with:
    - VNet
    - Subnet
    - NSG
    - Public IP
    - NIC
    - Windows Server 2019 Image

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

$params = Import-Csv -Path "./params/Create-AzureVM.csv"

foreach ($p in $params) {
    try {
        if (-not (Get-AzContext)) {
            Connect-AzAccount
        }

        $securePwd = ConvertTo-SecureString $p.AdminPassword -AsPlainText -Force
        $cred = New-Object System.Management.Automation.PSCredential ($p.AdminUsername, $securePwd)

        # Create Resource Group if it doesn't exist
        if (-not (Get-AzResourceGroup -Name $p.ResourceGroupName -ErrorAction SilentlyContinue)) {
            Write-Output "Creating resource group '$($p.ResourceGroupName)'..."
            New-AzResourceGroup -Name $p.ResourceGroupName -Location $p.Location
        }

        # Create VNet & Subnet
        Write-Output "Creating Virtual Network and Subnet..."
        $vnet = New-AzVirtualNetwork -ResourceGroupName $p.ResourceGroupName -Location $p.Location `
            -Name "$($p.VMName)-vnet" -AddressPrefix "10.0.0.0/16" `
            -Subnet @{{Name="$($p.VMName)-subnet"; AddressPrefix="10.0.0.0/24"}}

        # Create Public IP
        $pip = New-AzPublicIpAddress -Name "$($p.VMName)-pip" -ResourceGroupName $p.ResourceGroupName `
            -Location $p.Location -AllocationMethod Dynamic

        # Create NSG
        $nsg = New-AzNetworkSecurityGroup -Name "$($p.VMName)-nsg" -ResourceGroupName $p.ResourceGroupName `
            -Location $p.Location

        # Create NIC
        $nic = New-AzNetworkInterface -Name "$($p.VMName)-nic" -ResourceGroupName $p.ResourceGroupName `
            -Location $p.Location -SubnetId $vnet.Subnets[0].Id `
            -NetworkSecurityGroupId $nsg.Id -PublicIpAddressId $pip.Id

        # Configure the VM
        $vmConfig = New-AzVMConfig -VMName $p.VMName -VMSize $p.VMSize |
            Set-AzVMOperatingSystem -Windows -ComputerName $p.VMName -Credential $cred `
                -ProvisionVMAgent -EnableAutoUpdate |
            Set-AzVMSourceImage -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" `
                -Skus "2019-Datacenter" -Version "latest" |
            Add-AzVMNetworkInterface -Id $nic.Id

        # Create the VM
        Write-Output "Creating the Virtual Machine..."
        New-AzVM -ResourceGroupName $p.ResourceGroupName -Location $p.Location -VM $vmConfig

        Write-Output "✅ VM '$($p.VMName)' has been successfully created."
    }
    catch {
        Write-Error "❌ Failed to create VM '$($p.VMName)': $_"
    }
}
