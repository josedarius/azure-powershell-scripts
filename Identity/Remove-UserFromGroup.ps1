<#
.SYNOPSIS
    Removes a user from a specified Azure AD group.

.DESCRIPTION
    Removes a user from a specified Azure AD group.
    Input values are provided through a CSV file in the ./params/ directory.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Remove-UserFromGroup.csv"
foreach ($p in $params) {
    $user = Get-AzADUser -UserPrincipalName $p.UserPrincipalName
    Remove-AzADGroupMember -TargetGroupObjectId $p.GroupObjectId -MemberObjectId $user.Id
}

