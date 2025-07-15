<#
.SYNOPSIS
    Adds or updates tags on a VM.

.DESCRIPTION
    Adds or updates tags on a VM. using input from CSV parameter file.

.NOTES
    Author: Darius James
    Email : josedarius@gmail.com
#>

$params = Import-Csv -Path "./params/Tag-AzureVM.csv"
foreach ($p in $params) {
    try {
        if (-not (Get-AzContext)) { Connect-AzAccount }
        $vm = Get-AzVM -ResourceGroupName $p.ResourceGroupName -Name $p.VMName
        $vm.Tags[$p.TagKey] = $p.TagValue
        Set-AzResource -ResourceId $vm.Id -Tag $vm.Tags -Force
        Write-Output "🏷️ Tag added: $($p.TagKey) = $($p.TagValue)"
    } catch {
        Write-Error "❌ Failed to tag VM: $_"
    }
}
