<#
.SYNOPSIS
    Lists all Azure AD groups in the tenant.

.DESCRIPTION
    Lists all Azure AD groups in the tenant.
    Input values are provided through a CSV file in the ./params/ directory.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

Get-AzADGroup | Format-Table DisplayName, Id

