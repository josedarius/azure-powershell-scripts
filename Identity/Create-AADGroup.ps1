<#
.SYNOPSIS
    Creates a new Azure AD security group.

.DESCRIPTION
    Creates a new Azure AD security group.
    Input values are provided through a CSV file in the ./params/ directory.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>
if (-not (Get-AzContext)) { Connect-AzAccount }

$params = Import-Csv -Path "./params/Create-AADGroup.csv"
foreach ($p in $params) {
    New-AzADGroup -DisplayName $p.GroupName -MailNickname $p.MailNickname -SecurityEnabled $true -MailEnabled $false
}

