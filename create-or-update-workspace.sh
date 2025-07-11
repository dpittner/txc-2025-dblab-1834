#!/bin/bash
echo "
{
  \"name\": \"$WORKSPACE_NAME\",
  \"shared_data\": {
    \"region\": \"$REGION\"
  },
  \"type\": [
    \"terraform_v1.5\"
  ],
  \"template_repo\": {
    \"url\": \"$GITHUB_URL\"
  },
  \"template_data\": [
    {
      \"folder\": \"terraform\",
      \"type\": \"terraform_v1.5\",
      \"env_values\": [
        {
          \"__netrc__\":\"[['github.ibm.com','token','$GITHUB_TOKEN']]\"
        }
      ]
    }
  ]
}
" > DO-NOT-COMMIT-create-workspace.json

ibmcloud login --apikey $IBMCLOUD_API_KEY
ibmcloud target -g $RESOURCE_GROUP -r $REGION

WORKSPACE_ID=$(ibmcloud schematics workspace list --output json | jq -r '.workspaces[] | select(.name=="'"$WORKSPACE_NAME"'") | .id' 2>/dev/null)
echo "Workspace ID is $WORKSPACE_ID"

if [ -z "$WORKSPACE_ID" ]; then
  echo "Workspace $WORKSPACE_NAME does not exist, creating..."
  ibmcloud schematics workspace new --file DO-NOT-COMMIT-create-workspace.json --github-token $GITHUB_TOKEN
else
  echo "Workspace $WORKSPACE_NAME exists, updating..."
  ibmcloud schematics workspace update --id $WORKSPACE_ID --file DO-NOT-COMMIT-create-workspace.json --github-token $GITHUB_TOKEN
fi
rm -rf DO-NOT-COMMIT-create-workspace.json
