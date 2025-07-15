<#
.SYNOPSIS
    Assigns a built-in or custom role to a user at subscription scope.

.DESCRIPTION
    Assigns a built-in or custom role to a user at subscription scope.
    Input values are provided through a CSV file in the ./params/ directory.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Assign-RoleToUser.csv"
foreach ($p in $params) {
    $user = Get-AzADUser -UserPrincipalName $p.UserPrincipalName
    New-AzRoleAssignment -ObjectId $user.Id -RoleDefinitionName $p.RoleName -Scope "/subscriptions/$(Get-AzContext).Subscription.Id"
}

