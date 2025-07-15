<#
.SYNOPSIS
    Sets lifecycle management policy to delete blobs after 30 days.

.DESCRIPTION
    Sets lifecycle management policy to delete blobs after 30 days.
    Script reads parameters from CSV and uses Azure PowerShell modules.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Set-LifecyclePolicy.csv"
foreach ($p in $params) {
    $rule = @{
        Rules = @(
            @{
                Enabled = $true;
                Name = "delete-after-30-days";
                Type = "Lifecycle";
                Definition = @{
                    Filters = @{ PrefixMatch = @[""] };
                    Actions = @{ BaseBlob = @{ Delete = @{ DaysAfterModificationGreaterThan = 30 } } }
                }
            }
        )
    }
    Set-AzStorageServiceProperty -ResourceGroupName $p.ResourceGroupName -AccountName $p.StorageAccountName -ServiceType Blob -Lifecycle $rule
}

