<#
.SYNOPSIS
    Creates a new Azure AD user account with specified parameters.

.DESCRIPTION
    Creates a new Azure AD user account with specified parameters.
    Parameters are provided from a CSV file in the ./params/ folder.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Create-AADUser.csv"
foreach ($p in $params) {
    $securePassword = ConvertTo-SecureString -String $p.Password -AsPlainText -Force
    New-AzADUser -UserPrincipalName $p.UserPrincipalName -DisplayName $p.DisplayName `
        -Password $securePassword -MailNickname $p.MailNickname -AccountEnabled $true
}

