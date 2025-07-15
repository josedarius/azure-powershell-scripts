<#
.SYNOPSIS
    Resets the password for a specific Azure AD user.

.DESCRIPTION
    Resets the password for a specific Azure AD user.
    Parameters are provided from a CSV file in the ./params/ folder.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Reset-AADUserPassword.csv"
foreach ($p in $params) {
    $securePassword = ConvertTo-SecureString -String $p.NewPassword -AsPlainText -Force
    Set-AzADUserPassword -UserPrincipalName $p.UserPrincipalName -Password $securePassword
}

