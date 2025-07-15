<#
.SYNOPSIS
    Fetches sign-in logs for all users.

.DESCRIPTION
    Fetches sign-in logs for all users.
    Input values are provided through a CSV file in the ./params/ directory.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

Search-AzGraph -Query "SigninLogs | project UserPrincipalName, Status, IPAddress, CreatedDateTime | limit 100"

