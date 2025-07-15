<#
.SYNOPSIS
    Updates the display name and usage location of an Azure AD user.

.DESCRIPTION
    Updates the display name and usage location of an Azure AD user.
    Input values are provided through a CSV file in the ./params/ directory.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Update-AADUser.csv"
foreach ($p in $params) {
    Update-AzADUser -UserPrincipalName $p.UserPrincipalName -DisplayName $p.DisplayName -UsageLocation $p.UsageLocation
}

