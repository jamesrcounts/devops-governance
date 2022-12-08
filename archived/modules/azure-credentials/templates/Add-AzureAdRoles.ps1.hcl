#!/usr/bin/env pwsh
$ErrorActionPreference = "Stop"

function Add-AzureADRole {
    param (
        [Parameter(Mandatory)]
        [string]$DisplayName
    )
    
    # Fetch Application Administrator role instance
    $role = Get-AzureADDirectoryRole | `
        Where-Object {$_.DisplayName -eq $DisplayName}

    # If role instance does not exist, instantiate it based on the role template
    if ($null -eq $role) {
        # Instantiate an instance of the role template
        $roleTemplate = Get-AzureADDirectoryRoleTemplate | `
            Where-Object {$_.DisplayName -eq $DisplayName}

        Enable-AzureADDirectoryRole -RoleTemplateId $roleTemplate.ObjectId

        # Fetch Application Administrator role instance again
        $role = Get-AzureADDirectoryRole | `
            Where-Object {$_.DisplayName -eq $DisplayName}
    }

    # Now that we have the object IDs for the AAD role, we will need to get both 
    # object IDs to add the role to the enterprise application. We can use the 
    # command below :
    Add-AzureADDirectoryRoleMember `
        -ObjectId $role.ObjectId `
        -RefObjectId ${principal_id}

    Write-Host "Added $${DisplayName}"
}

Connect-AzureAD
%{ for role in roles ~}
Add-AzureADRole -DisplayName '${role}'
%{ endfor ~}