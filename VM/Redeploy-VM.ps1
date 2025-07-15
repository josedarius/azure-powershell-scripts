<#
.SYNOPSIS
    Redeploys the VM to a new host in Azure.

.DESCRIPTION
    Redeploys the VM to a new host in Azure. using input from CSV parameter file.

.NOTES
    Author: Darius James
    Email : josedarius@gmail.com
#>

$params = Import-Csv -Path "./params/Redeploy-VM.csv"
foreach ($p in $params) {
    try {
        if (-not (Get-AzContext)) { Connect-AzAccount }
        Write-Output "🔄 Redeploying VM '$($p.VMName)'..."
        Set-AzVM -Redeploy -ResourceGroupName $p.ResourceGroupName -Name $p.VMName
        Write-Output "✅ Redeployment started for VM '$($p.VMName)'."
    } catch {
        Write-Error "❌ Failed to redeploy VM: $_"
    }
}
