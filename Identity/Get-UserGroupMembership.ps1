<#
.SYNOPSIS
    Lists the groups to which a user belongs.

.DESCRIPTION
    Lists the groups to which a user belongs.
    Input values are provided through a CSV file in the ./params/ directory.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Get-UserGroupMembership.csv"
foreach ($p in $params) {
    $user = Get-AzADUser -UserPrincipalName $p.UserPrincipalName
    Get-AzADUserMembership -ObjectId $user.Id
}

