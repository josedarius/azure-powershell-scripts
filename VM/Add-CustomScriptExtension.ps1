<#
.SYNOPSIS
    Adds a Custom Script Extension to a VM.

.DESCRIPTION
    Adds a Custom Script Extension to a VM. using input from CSV parameter file.

.NOTES
    Author: Darius James
    Email : josedarius@gmail.com
#>

$params = Import-Csv -Path "./params/Add-CustomScriptExtension.csv"
foreach ($p in $params) {
    try {
        if (-not (Get-AzContext)) { Connect-AzAccount }
        Set-AzVMCustomScriptExtension -ResourceGroupName $p.ResourceGroupName -VMName $p.VMName `
            -Name "CustomScriptExtension" -Location "westeurope" `
            -FileUri $p.ScriptUri -Run $p.CommandToExecute
        Write-Output "✅ Custom Script Extension added."
    } catch {
        Write-Error "❌ Failed to add extension: $_"
    }
}
