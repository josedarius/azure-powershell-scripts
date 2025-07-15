<#
.SYNOPSIS
    Deletes an Azure AD user from the directory.

.DESCRIPTION
    Deletes an Azure AD user from the directory.
    Input values are provided through a CSV file in the ./params/ directory.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Remove-AADUser.csv"
foreach ($p in $params) {
    Remove-AzADUser -UserPrincipalName $p.UserPrincipalName -Force
}

