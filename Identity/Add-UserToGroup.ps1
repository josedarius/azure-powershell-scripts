<#
.SYNOPSIS
    Adds a user to a specified Azure AD group.

.DESCRIPTION
    Adds a user to a specified Azure AD group.
    Input values are provided through a CSV file in the ./params/ directory.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Add-UserToGroup.csv"
foreach ($p in $params) {
    $user = Get-AzADUser -UserPrincipalName $p.UserPrincipalName
    Add-AzADGroupMember -TargetGroupObjectId $p.GroupObjectId -MemberObjectId $user.Id
}

