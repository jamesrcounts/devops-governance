#!/usr/bin/env pwsh

$dsiplayName = 'Application Administrator'

# Fetch Application Administrator role instance
$role = Get-AzureADDirectoryRole | `
    Where-Object {$_.displayName -eq $dsiplayName}

# If role instance does not exist, instantiate it based on the role template
if ($null -eq $role) {
    # Instantiate an instance of the role template
    $roleTemplate = Get-AzureADDirectoryRoleTemplate | `
        Where-Object {$_.displayName -eq $dsiplayName}
    
    Enable-AzureADDirectoryRole -RoleTemplateId $roleTemplate.ObjectId

    # Fetch Application Administrator role instance again
    $role = Get-AzureADDirectoryRole | `
        Where-Object {$_.displayName -eq $dsiplayName}
}

# Now that we have the object IDs for the AAD role, we will need to get both 
# object IDs to add the role to the enterprise application. We can use the 
# command below :
Add-AzureADDirectoryRoleMember `
    -ObjectId $role.ObjectId `
    -RefObjectId ${principal_id}
