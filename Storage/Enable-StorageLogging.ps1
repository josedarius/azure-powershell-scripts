<#
.SYNOPSIS
    Enables metrics and logging for storage account operations.

.DESCRIPTION
    Enables metrics and logging for storage account operations.
    Script reads parameters from CSV and uses Azure PowerShell modules.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Enable-StorageLogging.csv"
foreach ($p in $params) {
    Set-AzStorageServiceLoggingProperty -ServiceType Blob -LoggingOperations Read,Write,Delete `
        -RetentionDays 7 -Version 1.0 -ResourceGroupName $p.ResourceGroupName -StorageAccountName $p.StorageAccountName
}

