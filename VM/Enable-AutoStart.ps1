<#
.SYNOPSIS
    Enables auto-start using Azure Automation.

.DESCRIPTION
    Enables auto-start using Azure Automation. using input from CSV parameter file.

.NOTES
    Author: Darius James
    Email : josedarius@gmail.com
#>

$params = Import-Csv -Path "./params/Enable-AutoStart.csv"
foreach ($p in $params) {
    try {
        if (-not (Get-AzContext)) { Connect-AzAccount }
        Write-Output "ℹ️ Auto-start logic would go here using Automation Runbooks (to be implemented manually)."
    } catch {
        Write-Error "❌ Failed: $_"
    }
}
