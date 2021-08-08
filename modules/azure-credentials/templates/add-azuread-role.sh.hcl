#!/usr/bin/env bash
set -euo pipefail

BASE_URL='https://graph.microsoft.com/v1.0'

# Builds the body to post to directoryRoles endpoint to activate a role
activate_directory_role_body () {
    ROLE_TEMPLATE_ID=$${1}

    printf '{"roleTemplateId": "%s"}' $${ROLE_TEMPLATE_ID}
}

# Builds the body to post to the directoryRoles member endpoint
add_directory_role_member_body () {
    MEMBER_ID=$${1}

    printf '{"@odata.id": "%s/directoryObjects/%s"}' $${BASE_URL} $${MEMBER_ID}
}

# Builds URL for the Graph API directoryRoles endpoint
endpoint_directory_roles () {
    printf "%s" $${BASE_URL} '/directoryRoles'
}

# Builds and formats an oData filter clause
odata_filter () {
    RAW_FILTER=$${1}

    FILTER=$(printf "$${RAW_FILTER}" | jq -sRr @uri)

    printf '$filter=%s' $${FILTER}
}

# Query the Graph API activated roles and returns the ID for the role matching
# DISPLAY_NAME; otherwise returns null
get_azuread_directory_role () {
    DISPLAY_NAME="$${1}"

    SELECT='$select=id'
    FILTER=$(odata_filter "displayName eq '$${DISPLAY_NAME}'")

    URL=$(printf "%s" $(endpoint_directory_roles) '?' $${SELECT} '&' $${FILTER})
    ROLE_ID=$(az rest --method get --url $${URL} | jq -r '.value | first | .id')

    printf $${ROLE_ID}
}

# Query the Graph API role templates and returns the ID for the role template 
# matching DISPLAY_NAME; otherwise returns null
get_azuread_directory_role_template () {
    DISPLAY_NAME="$${1}"

    URL=$(printf "%s" $${BASE_URL} '/directoryRoleTemplates')

    ROLE_TEMPLATE_ID=$(az rest --method get --url $${URL} | \
                        jq -r ".value | map(select(.displayName == \"$${DISPLAY_NAME}\")) | first | .id")
    
    printf $${ROLE_TEMPLATE_ID}
}

# Activates the role template for the given role tempalte ID
enable_azuread_directory_role () {
    ROLE_TEMPLATE_ID=$${1}

    URL=$(endpoint_directory_roles)
    BODY=$(activate_directory_role_body $${ROLE_TEMPLATE_ID})

    az rest --method post \
        --url $${URL} \
        --body "$${BODY}"
}

# Create a new directory role member
add_azuread_directory_role_member () {
    AAD_ROLE_ID=$${1}
    MEMBER_ID=$${2}

    URL=$(printf "%s" $(endpoint_directory_roles) '/' $${AAD_ROLE_ID} '/members/$$ref')
    ENDPOINT_BODY=$(add_directory_role_member_body $${MEMBER_ID})

    az rest --method post \
        --url $${URL} \
        --body "$${ENDPOINT_BODY}"
}

# Search a principal's memberships for an AAD role
check_principal_directory_role () {
    MEMBER_ID=$${1}
    AAD_ROLE_ID=$${2}

    ENDPOINT_URL=$(printf "%s" $${BASE_URL} '/servicePrincipals/' $${MEMBER_ID} '/memberOf/microsoft.graph.directoryRole')
    SELECT='$select=id'
    URL=$(printf "%s" $${ENDPOINT_URL} '?' $${SELECT})
    ROLE_COUNT=$(az rest --method get \
                    --url $${URL} | \
                    jq -r ".value | map(select(.id == \"$${AAD_ROLE_ID}\")) | length")

    printf $${ROLE_COUNT}
}

# Checks that an activated AAD role exists by display name and activates that
# role if needed
ensure_azuread_role () {
    DISPLAY_NAME=$${1}

    AAD_ROLE_ID=$(get_azuread_directory_role "$${DISPLAY_NAME}")
    if [ -z "$${AAD_ROLE_ID}" ]
    then
        ROLE_TEMPLATE_ID=$(get_azuread_directory_role_template "$${DISPLAY_NAME}")
        enable_azuread_directory_role $${ROLE_TEMPLATE_ID}
        AAD_ROLE_ID=$(get_azuread_directory_role "$${DISPLAY_NAME}")
    fi

    printf $${AAD_ROLE_ID}
}

# Checks that a principal is a member of the specified AAD role and adds that
# principal to the role if needed.
ensure_azuread_role_membership () {
    MEMBER_ID=$${1}
    AAD_ROLE_ID=$${2}
    DISPLAY_NAME=$${3}
    
    ROLE_COUNT=$(check_principal_directory_role $${MEMBER_ID} $${AAD_ROLE_ID})
    if [ 0 == "$${ROLE_COUNT}" ]
    then
        add_azuread_directory_role_member $${AAD_ROLE_ID} $${MEMBER_ID}
        echo "Added principal to role: $${DISPLAY_NAME}"
    fi

    echo "Principal has membership for role: $${DISPLAY_NAME}"
}

PRINCIPAL_ID="${principal_id}"

ROLE_NAMES=(
%{ for role in roles ~}
    '${role}'
%{ endfor ~}
)
for ROLE_NAME in "$${ROLE_NAMES[@]}"
do
    ROLE_ID=$(ensure_azuread_role "$${ROLE_NAME}")
    ensure_azuread_role_membership $${PRINCIPAL_ID} $${ROLE_ID} "$${ROLE_NAME}"
done