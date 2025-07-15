<#
.SYNOPSIS
    Creates a custom Azure RBAC role using default permissions.

.DESCRIPTION
    Creates a custom Azure RBAC role using default permissions.
    Input values are provided through a CSV file in the ./params/ directory.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Create-CustomRole.csv"
foreach ($p in $params) {
    $roleDef = @{
        Name = $p.RoleName
        Description = $p.Description
        Actions = @("Microsoft.Resources/subscriptions/resourceGroups/read", "Microsoft.Tagging/tagKeys/read", "Microsoft.Tagging/tagValues/read")
        NotActions = @()
        AssignableScopes = @("/subscriptions/" + (Get-AzContext).Subscription.Id)
    }
    New-AzRoleDefinition -InputObject $roleDef
}

