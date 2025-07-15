<#
.SYNOPSIS
    Sets CORS rules for the storage account.

.DESCRIPTION
    Sets CORS rules for the storage account.
    Script reads parameters from CSV and uses Azure PowerShell modules.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Set-CORSRules.csv"
foreach ($p in $params) {
    $cors = @{
        CorsRules = @(
            @{
                AllowedHeaders = "*";
                AllowedMethods = "GET,PUT,POST";
                AllowedOrigins = "*";
                ExposedHeaders = "*";
                MaxAgeInSeconds = 3600
            }
        )
    }
    Set-AzStorageCORSRule -ServiceType Blob -ResourceGroupName $p.ResourceGroupName -StorageAccountName $p.StorageAccountName -CorsRules $cors["CorsRules"]
}

