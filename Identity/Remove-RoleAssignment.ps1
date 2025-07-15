<#
.SYNOPSIS
    Removes a role assignment from a user.

.DESCRIPTION
    Removes a role assignment from a user.
    Input values are provided through a CSV file in the ./params/ directory.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Remove-RoleAssignment.csv"
foreach ($p in $params) {
    $user = Get-AzADUser -UserPrincipalName $p.UserPrincipalName
    Remove-AzRoleAssignment -ObjectId $user.Id -RoleDefinitionName $p.RoleName -Scope "/subscriptions/$(Get-AzContext).Subscription.Id"
}

