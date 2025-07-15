<#
.SYNOPSIS
    Unblocks sign-in for a user.

.DESCRIPTION
    Unblocks sign-in for a user.
    Input values are provided through a CSV file in the ./params/ directory.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Unblock-SignIn.csv"
foreach ($p in $params) {
    Update-AzADUser -UserPrincipalName $p.UserPrincipalName -AccountEnabled $true
}

