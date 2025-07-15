<#
.SYNOPSIS
    Generates a Shared Access Signature (SAS) token for a blob container.

.DESCRIPTION
    Generates a Shared Access Signature (SAS) token for a blob container.
    Script reads parameters from CSV and uses Azure PowerShell modules.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Generate-SASToken.csv"
foreach ($p in $params) {
    $ctx = (Get-AzStorageAccount -ResourceGroupName $p.ResourceGroupName -Name $p.StorageAccountName).Context
    $sas = New-AzStorageContainerSASToken -Name $p.ContainerName -Permission rwdl -Context $ctx -ExpiryTime (Get-Date).AddDays(7) -FullUri
    Write-Output "SAS URL: $sas"
}

