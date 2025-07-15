<#
.SYNOPSIS
    Stops (deallocates) an Azure Virtual Machine.

.DESCRIPTION
    Reads VM name and resource group from a CSV file and stops the specified VM to save cost.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

$params = Import-Csv -Path "./params/Stop-AzureVM.csv"

foreach ($p in $params) {
    try {
        if (-not (Get-AzContext)) {
            Connect-AzAccount
        }

        Write-Output "⏹️ Stopping VM '$($p.VMName)' in Resource Group '$($p.ResourceGroupName)'..."
        Stop-AzVM -ResourceGroupName $p.ResourceGroupName -Name $p.VMName -Force -ErrorAction Stop
        Write-Output "✅ VM '$($p.VMName)' stopped and deallocated successfully."
    }
    catch {
        Write-Error "❌ Failed to stop VM '$($p.VMName)': $_"
    }
}
