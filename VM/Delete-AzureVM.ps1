<#
.SYNOPSIS
    Deletes a virtual machine.

.DESCRIPTION
    Deletes a virtual machine. using input from CSV parameter file.

.NOTES
    Author: Darius James
    Email : josedarius@gmail.com
#>

$params = Import-Csv -Path "./params/Delete-AzureVM.csv"
foreach ($p in $params) {
    try {
        if (-not (Get-AzContext)) { Connect-AzAccount }
        Remove-AzVM -Name $p.VMName -ResourceGroupName $p.ResourceGroupName -Force
        Write-Output "🗑️ VM '$($p.VMName)' deleted successfully."
    } catch {
        Write-Error "❌ Failed to delete VM: $_"
    }
}
