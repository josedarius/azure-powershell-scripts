<#
.SYNOPSIS
    Enables auto-shutdown for a VM at a specified UTC time.

.DESCRIPTION
    Enables auto-shutdown for a VM at a specified UTC time.
    This script performs the operation using Azure PowerShell and optionally takes input from a CSV file.

.NOTES
    Author : Darius James
    Email  : josedarius@gmail.com
#>

if (-not (Get-AzContext)) { Connect-AzAccount }

$vmParams = Import-Csv -Path "./params/Enable-AutoShutdown.csv"
foreach ($param in $vmParams) {
    $vm = Get-AzVM -ResourceGroupName $param.ResourceGroupName -Name $param.VMName
    $vmId = $vm.Id
    $shutdownConfig = @{
        "location" = "westeurope";
        "properties" = @{
            "status" = "Enabled";
            "taskType" = "AutoShutdown";
            "dailyRecurrence" = @{ "time" = $param.Time };
            "timeZoneId" = "UTC";
            "notificationSettings" = @{ "status" = "Disabled" };
            "targetResourceId" = $vmId
        }
    }
    New-AzResource -Location "westeurope" -ResourceId "$vmId/providers/microsoft.devtestlab/schedules/shutdown-computevm" `
        -Properties $shutdownConfig["properties"] -Force
}

