<#
.SYNOPSIS
    Resizes an Azure VM to a specified size.

.DESCRIPTION
    Resizes an Azure VM to a specified size. using input from CSV parameter file.

.NOTES
    Author: Darius James
    Email : josedarius@gmail.com
#>

$params = Import-Csv -Path "./params/Resize-AzureVM.csv"
foreach ($p in $params) {
    try {
        if (-not (Get-AzContext)) { Connect-AzAccount }
        $vm = Get-AzVM -ResourceGroupName $p.ResourceGroupName -Name $p.VMName
        $vm.HardwareProfile.VmSize = $p.VMSize
        Update-AzVM -VM $vm -ResourceGroupName $p.ResourceGroupName
        Write-Output "✅ Resized VM '$($p.VMName)' to '$($p.VMSize)'."
    } catch {
        Write-Error "❌ Failed to resize VM: $_"
    }
}
