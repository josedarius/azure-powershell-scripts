<#
.SYNOPSIS
    Lists role assignments for a given user.

.DESCRIPTION
    Lists role assignments for a given user.
    Input values are provided through a CSV file in the ./params/ directory.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/List-RoleAssignments.csv"
foreach ($p in $params) {
    $user = Get-AzADUser -UserPrincipalName $p.UserPrincipalName
    Get-AzRoleAssignment -ObjectId $user.Id
}

