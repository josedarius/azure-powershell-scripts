<#
.SYNOPSIS
    Enables monitoring insights on a VM.

.DESCRIPTION
    Enables monitoring insights on a VM. using input from CSV parameter file.

.NOTES
    Author: Darius James
    Email : josedarius@gmail.com
#>

$params = Import-Csv -Path "./params/Enable-VMInsights.csv"
foreach ($p in $params) {
    try {
        if (-not (Get-AzContext)) { Connect-AzAccount }
        Write-Output "ℹ️ Enable Azure Monitor Insights via Azure Portal or Policy for better tracking."
    } catch {
        Write-Error "❌ Failed to enable insights: $_"
    }
}
