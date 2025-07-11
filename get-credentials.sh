#!/bin/bash
ibmcloud login --apikey $IBMCLOUD_API_KEY
ibmcloud target -g $RESOURCE_GROUP -r $REGION
WORKSPACE_ID=$(ibmcloud schematics workspace list --output json | jq -r '.workspaces[] | select(.name=="'"$WORKSPACE_NAME"'") | .id' 2>/dev/null)

echo "Saving credentials for workspace $WORKSPACE_ID to credentials.csv..."
ibmcloud schematics output --id $WORKSPACE_ID --output json | jq -r '.[0].output_values[0].user_passwords_as_csv.value' > credentials.csv
