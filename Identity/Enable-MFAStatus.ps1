<#
.SYNOPSIS
    Enforces MFA registration and reports users not registered.

.DESCRIPTION
    Enforces MFA registration and reports users not registered.
    Input values are provided through a CSV file in the ./params/ directory.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

# Report users without MFA registration
Get-MsolUser -All | Where-Object { $_.StrongAuthenticationRequirements.Count -eq 0 } | 
    Select-Object DisplayName, UserPrincipalName

# Enforce MFA
$users = Get-MsolUser -All | Where-Object { $_.StrongAuthenticationRequirements.Count -eq 0 }
foreach ($user in $users) {
    $mfa = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
    $mfa.RelyingParty = "*"
    $mfa.State = "Enabled"
    Set-MsolUser -UserPrincipalName $user.UserPrincipalName -StrongAuthenticationRequirements @($mfa)
}

