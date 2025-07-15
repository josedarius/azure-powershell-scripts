<#
.SYNOPSIS
    Blocks sign-in for the specified Azure AD user.

.DESCRIPTION
    Blocks sign-in for the specified Azure AD user.
    Parameters are provided from a CSV file in the ./params/ folder.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Block-SignIn.csv"
foreach ($p in $params) {
    Update-AzADUser -UserPrincipalName $p.UserPrincipalName -AccountEnabled $false
}

