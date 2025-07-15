<#
.SYNOPSIS
    Uploads a file to Azure File Share.

.DESCRIPTION
    Uploads a file to Azure File Share.
    Script reads parameters from CSV and uses Azure PowerShell modules.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Upload-ToFileShare.csv"
foreach ($p in $params) {
    $ctx = (Get-AzStorageAccount -Name $p.StorageAccountName -ResourceGroupName $p.ResourceGroupName).Context
    Set-AzStorageFileContent -ShareName $p.ShareName -Source $p.SourceFilePath -Path "/" -Context $ctx
}

