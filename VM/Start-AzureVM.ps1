<#
.SYNOPSIS
    Starts an Azure Virtual Machine.

.DESCRIPTION
    Reads VM name and resource group from a CSV file, then starts the specified VM.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

$params = Import-Csv -Path "./params/Start-AzureVM.csv"

foreach ($p in $params) {
    try {
        if (-not (Get-AzContext)) {
            Connect-AzAccount
        }

        Write-Output "🔄 Starting VM '$($p.VMName)' in Resource Group '$($p.ResourceGroupName)'..."
        Start-AzVM -ResourceGroupName $p.ResourceGroupName -Name $p.VMName -ErrorAction Stop
        Write-Output "✅ VM '$($p.VMName)' started successfully."
    }
    catch {
        Write-Error "❌ Failed to start VM '$($p.VMName)': $_"
    }
}
